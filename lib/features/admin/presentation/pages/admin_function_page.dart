import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/key_code_constants.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/services/scan_service.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../../../../core/widgets/dropdown_menu_button.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/loading_dialog.dart';
import '../../../../core/widgets/notification_dialog.dart';
import '../../../../core/widgets/scafford_custom.dart';
import '../../../auth/login/domain/entities/user_entity.dart';
import '../../../home_data/presentation/bloc/home_data_bloc_factory.dart';
import '../../../home_data/presentation/bloc/home_data_bloc.dart';
import '../../../home_data/presentation/bloc/home_data_event.dart';
import '../../../home_data/presentation/bloc/home_data_state.dart';
import '../../../home_data/presentation/widgets/home_data_component.dart';
import '../bloc/admin_action_bloc.dart';
import '../bloc/admin_action_event.dart';
import '../bloc/admin_action_state.dart';
import '../widgets/admin_scanner_widget.dart';
import '../widgets/scanned_data_widget.dart';

class AdminFunctionPageWithHomeData extends StatefulWidget {
  final UserEntity user;
  final String title;
  final String actionType;
  final String successMessage;
  final String functionType;
  
  const AdminFunctionPageWithHomeData({
    super.key,
    required this.user,
    required this.title,
    required this.actionType,
    required this.successMessage,
    required this.functionType,
  });

  @override
  State<AdminFunctionPageWithHomeData> createState() => _AdminFunctionPageWithHomeDataState();
}

class _AdminFunctionPageWithHomeDataState extends State<AdminFunctionPageWithHomeData> with WidgetsBindingObserver {
  MobileScannerController? _controller;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  bool _cameraActive = false;
  bool _torchEnabled = false;
  bool _showDataView = false;
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
        detectionSpeed: DetectionSpeed.normal,
        detectionTimeoutMs: 1000,
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
        title: 'CAMERA ERROR',
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
      title: 'CONFIRM ACTION',
      message: 'Are you sure you want to perform this action ?',
      confirmColor: AppColors.alert,
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
    final homeDataConfig = HomeDataBlocFactory.getConfigForFunction(widget.functionType);
    final HomeDataBloc homeDataBloc = HomeDataBlocFactory.createBloc(widget.user, widget.functionType);
    
    return BlocProvider<HomeDataBloc>(
      create: (context) => homeDataBloc,
      child: BlocConsumer<AdminActionBloc, AdminActionState>(
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
              title: 'SUCCESS',
              message: widget.successMessage,
              icon: Icons.check_circle_outline,
              iconColor: AppColors.success,
              onDismiss: () {
                _clearData();
                homeDataBloc.refreshData();
              }
            );
          } else if (state is AdminActionError) {
            LoadingDialog.hide(context);
            
            ErrorDialog.showAsync(
              context,
              title: 'ERROR',
              message: 'Cannot perform action, please check again',
            );
          }
        },
        builder: (context, state) {
          return CustomScaffold(
            key: _scaffoldKey,
            title: widget.title,
            user: widget.user,
            currentIndex: _showDataView ? 0 : 1,
            showHomeIcon: true,
            customNavBarCallback: (index) {
              if (index == 0 && !_showDataView) {
                setState(() {
                  _showDataView = true;
                });
                return true;
              }
              if (index == 1 && _showDataView) {
                setState(() {
                  _showDataView = false;
                });
                return true;
              }
              return false;
            },
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
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF283048),
                      Color(0xFF859398),
                    ],
                  ),
                ),
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (!_showDataView) ...[
                      SizedBox(
                        child: AdminScannerWidget(
                          controller: _controller,
                          onDetect: _onDetect,
                          isActive: _cameraActive,
                          onToggle: _toggleCamera,
                        ),
                      ),
                
                      const SizedBox(height: 10),
                
                      if (state is AdminActionDataLoaded) ...[
                        SizedBox(
                          height: 300,
                          child: ScannedData(
                            data: state.data,
                            actionType: widget.actionType,
                            onExecute: () => _executeAction(state.data.code),
                          ),
                        ),
                      ] else if ((state is! AdminActionDataLoading)) ...[
                        Container(
                          width: double.infinity,
                          height: 300,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldBackground,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackCommon.withValues(alpha: 0.05),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 12),
                              Text(
                                  'Scan a QR code to get item details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      ],
                
                      const Spacer(),
                
                      ElevatedButton(
                       onPressed: _currentCode.isEmpty ? null : () => _executeAction(_currentCode),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
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
                
                    ] else ...[
                      Expanded(
                        child: HomeDataComponent(
                          user: widget.user,
                          config: homeDataConfig,
                          bloc: homeDataBloc,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              ),
            ),
            actions: [
              AppBarActionsButton(
                isDataView: _showDataView,
                isCameraActive: _cameraActive,
                isTorchEnabled: _torchEnabled,
                onCalendarTap: () => _selectDate(context),
                onRefreshTap: () => context.read<HomeDataBloc>().refreshData(),
                onTorchToggle: _toggleTorch,
                onCameraFlip: _switchCamera,
                onCameraToggle: _toggleCamera,
                onClearData: () {
                  ConfirmationDialog.showAsync(
                    context,
                    title: 'CLEAR DATA',
                    message: 'Are you sure you want to clear all data?',
                    confirmColor: AppColors.alert,
                    onConfirm: _clearData,
                    onCancel: () {},
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
  
  Future<void> _selectDate(BuildContext context) async {

    final currentState = context.read<HomeDataBloc>().state;
    final DateTime initialDate = currentState is HomeDataLoaded ? currentState.selectedDate : DateTime.now();
        
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if(!context.mounted) return;

    if (picked != null && picked != initialDate) {
      context.read<HomeDataBloc>().add(SelectDateEvent(selectedDate: picked));
    }
  }
}