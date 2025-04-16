import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/key_code_constants.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/services/scan_service.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/loading_dialog.dart';
import '../../../../core/widgets/notification_dialog.dart';
import '../../../../core/widgets/scafford_custom.dart';
import '../../../auth/login/domain/entities/user_entity.dart';
import '../bloc/admin_action_bloc.dart';
import '../bloc/admin_action_event.dart';
import '../bloc/admin_action_state.dart';
import '../widgets/admin_scanner_widget.dart';

class AdminActionPage extends StatefulWidget {
  final UserEntity user;
  final String title;
  final String actionType;
  final String successMessage;
  
  const AdminActionPage({
    super.key,
    required this.user,
    required this.title,
    required this.actionType,
    required this.successMessage,
  });

  @override
  State<AdminActionPage> createState() => _AdminActionPageState();
}

class _AdminActionPageState extends State<AdminActionPage> with WidgetsBindingObserver {
  MobileScannerController? _controller;
  final FocusNode _focusNode = FocusNode();
  
  bool _cameraActive = false;
  bool _torchEnabled = false;
  String _currentCode = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode.requestFocus();
    
    ScanService.initializeScannerListenerAsync((scannedData) {
      debugPrint("QR DEBUG: Hardware scanner callback with data: $scannedData");
      if (mounted) {
        context.read<AdminActionBloc>().add(HardwareScanEvent(scannedData));
      }
    });
    
    _initializeCameraController();
  }

  @override
  void dispose() {
    _cleanUpCamera();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.dispose();
    ScanService.disposeScannerListenerAsync();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _cleanUpCamera();
    } else if (state == AppLifecycleState.resumed) {
      if (_cameraActive) {
        _initializeCameraController();
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (mounted) {
      NavigationService().setLastAdminRoute(ModalRoute.of(context)?.settings.name);
    }
  }

  void _initializeCameraController() {
    _cleanUpCamera();

    try {
      _controller = MobileScannerController(
        formats: const [
          BarcodeFormat.qrCode,
          BarcodeFormat.code128,
          BarcodeFormat.code39,
          BarcodeFormat.ean8,
          BarcodeFormat.ean13,
          BarcodeFormat.upcA,
          BarcodeFormat.upcE,
          BarcodeFormat.codabar,
        ],
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
        returnImage: false,
        torchEnabled: _torchEnabled,
      );

      context.read<AdminActionBloc>().add(InitializeScannerEvent(_controller!));
      
      if (!_cameraActive && _controller != null) {
        _controller!.stop();
      }
    } catch (e) {
      debugPrint("QR DEBUG: ⚠️ Camera initialization error: $e");
      ErrorDialog.showAsync(
        context,
        title: 'Camera Error',
        message: "Camera initialization error: $e",
      );
    }
  }

  void _cleanUpCamera() {
    if (_controller != null) {
      try {
        _controller?.stop();
        _controller?.dispose();
      } catch (e) {
        debugPrint("QR DEBUG: ⚠️ Error disposing camera: $e");
      }
      _controller = null;
    }
  }

  void _toggleCamera() {
    debugPrint("QR DEBUG: Toggle camera button pressed");
    setState(() {
      _cameraActive = !_cameraActive;

      if (_cameraActive) {
        try {
          if (_controller == null) {
            _initializeCameraController();
          }
          _controller!.start();
        } catch (e) {
          debugPrint("QR DEBUG: Error starting camera: $e");
          _cleanUpCamera();
          _initializeCameraController();
          _controller?.start();
        }
      } else if (_controller != null) {
        _controller?.stop();
      }
    });
  }

  Future<void> _toggleTorch() async {
    debugPrint("QR DEBUG: Toggle torch button pressed");
    if (_controller != null && _cameraActive) {
      await _controller!.toggleTorch();
      setState(() {
        _torchEnabled = !_torchEnabled;
      });
    }
  }

  Future<void> _switchCamera() async {
    debugPrint("QR DEBUG: Switch camera button pressed");
    if (_controller != null && _cameraActive) {
      await _controller!.switchCamera();
    }
  }

  void _clearData() {
    setState(() {
      _currentCode = '';
    });
    context.read<AdminActionBloc>().add(ClearScannedDataEvent());
  }

  void _executeAction(String code) {
    final actionType = widget.actionType;
    
    ConfirmationDialog.showAsync(
      context,
      title: 'Confirm Action',
      message: 'Are you sure you want to perform this action on code: $code?',
      confirmColor: Colors.redAccent,
      onConfirm: () {
        context.read<AdminActionBloc>().add(ExecuteActionEvent(
          code: code,
          actionType: actionType,
        ));
      },
      onCancel: () {},
    );
  }

  void _onDetect(BarcodeCapture capture) {
    debugPrint("QR DEBUG: === Barcode detected: ${capture.barcodes.length} ===");

    if (capture.barcodes.isEmpty) {
      debugPrint("QR DEBUG: No barcodes detected in this frame");
      return;
    }

    for (final barcode in capture.barcodes) {
      final rawValue = barcode.rawValue;
      final format = barcode.format;

      debugPrint("QR DEBUG: Format: $format");
      debugPrint("QR DEBUG: RawValue: $rawValue");

      if (rawValue == null || rawValue.isEmpty) {
        debugPrint("QR DEBUG: ⚠️ Empty barcode value");
        continue;
      }

      debugPrint("QR DEBUG: ✅ QR value success: $rawValue");

      if (mounted) {
        context.read<AdminActionBloc>().add(ScanBarcodeEvent(rawValue));
      }

      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminActionBloc, AdminActionState>(
      listener: (context, state) {
        if (state is AdminActionCodeScanned) {
          setState(() {
            _currentCode = state.code;
          });
        } else if (state is AdminActionProcessing) {
          LoadingDialog.show(context);
        } else if (state is AdminActionSuccess) {
          LoadingDialog.hide(context);
          
          NotificationDialog.show(
            context,
            title: 'Success',
            message: widget.successMessage,
            icon: Icons.check_circle_outline,
            iconColor: Colors.green,
            onDismiss: () {
              _clearData();
            }
          );
        } else if (state is AdminActionError) {
          LoadingDialog.hide(context);
          
          ErrorDialog.showAsync(
            context,
            title: 'Error',
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          title: widget.title,
          user: widget.user,
          currentIndex: 1,
          showHomeIcon: true,
          body: KeyboardListener(
            focusNode: _focusNode,
            autofocus: true,
            onKeyEvent: (KeyEvent event) async {
              if (event is KeyDownEvent) {
                debugPrint("QR DEBUG: Key pressed: ${event.logicalKey.keyId}");
                if (KeycodeConstants.scannerKeyCodes.contains(
                  event.logicalKey.keyId,
                )) {
                  debugPrint("QR DEBUG: Scanner key pressed");
                } else if (await ScanService.isScannerButtonPressedAsync(event)) {
                  debugPrint("QR DEBUG: Scanner key pressed via ScanService");
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
              child: Column(
                children: [
                  SizedBox(
                    child: AdminScannerWidget(
                      controller: _controller,
                      onDetect: _onDetect,
                      isActive: _cameraActive,
                      onToggle: _toggleCamera,
                    ),
                  ),
          
                  const SizedBox(height: 10),
          
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Scanned Code:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _currentCode.isEmpty ? 'No code scanned yet' : _currentCode,
                          style: TextStyle(
                            fontSize: 14,
                            color: _currentCode.isEmpty ? Colors.grey : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
          
                  const Spacer(),
          
                  ElevatedButton(
                    onPressed: _currentCode.isEmpty ? null : () => _executeAction(_currentCode),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      widget.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
          
                  const Spacer(),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildEnhancedButton(
                        icon: Icon(
                          _torchEnabled ? Icons.flash_on : Icons.flash_off,
                          color: _torchEnabled ? Colors.yellow : Colors.white,
                          size: 28,
                        ),
                        onPressed: _cameraActive ? _toggleTorch : null,
                        label: 'Flash',
                        color: _torchEnabled ? Colors.amber.shade700 : Colors.blueGrey.shade700,
                      ),
                      const SizedBox(width: 16),
                      _buildEnhancedButton(
                        icon: const Icon(
                          Icons.flip_camera_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: _cameraActive ? _switchCamera : null,
                        label: 'Flip',
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 16),
                      _buildEnhancedButton(
                        icon: Icon(
                          _cameraActive ? Icons.stop : Icons.play_arrow,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: _toggleCamera,
                        label: _cameraActive ? 'Stop' : 'Start',
                        color: _cameraActive ? Colors.red.shade700 : Colors.green.shade700,
                      ),
                      const SizedBox(width: 16),
                      _buildEnhancedButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: _currentCode.isNotEmpty ? _clearData : null,
                        label: 'Clear',
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildEnhancedButton({
    required Widget icon,
    required VoidCallback? onPressed,
    required String label,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: onPressed == null ? color.withValues(alpha: 0.5) : color,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(28),
              child: Center(child: icon),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: onPressed == null ? Colors.grey : Colors.black87,
          ),
        ),
      ],
    );
  }
}