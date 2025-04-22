import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/app_colors.dart';

class AdminScannerWidget extends StatelessWidget {
  final MobileScannerController? controller;
  final Function(BarcodeCapture)? onDetect;
  final bool isActive;
  final VoidCallback onToggle;
  
  const AdminScannerWidget({
    super.key,
    required this.controller,
    required this.onDetect,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("Building AdminScannerWidget, camera active: $isActive");
    
    return Stack(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyCommon.withValues(alpha: 0.7), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: isActive && controller != null
              ? MobileScanner(
                  controller: controller!,
                  onDetect: (barcodes) {
                    debugPrint("QR DEBUG: onDetect called from MobileScanner");
                    if (onDetect != null) {
                      onDetect!(barcodes);
                    }
                  },
                  placeholderBuilder: (context, child) {
                    return Container(
                      color: AppColors.blackCommon,
                      child: const Center(
                        child: Text(
                          "Initializing camera...",
                          style: TextStyle(color: AppColors.whiteCommon),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, child) {
                    debugPrint("QR DEBUG: Camera error: ${error.errorCode}");
                    return Container(
                      color: AppColors.blackCommon,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error, color: AppColors.redCommon, size: 50),
                            Text(
                              "Camera error: ${error.errorCode}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.redCommon),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(AppColors.warning),
                                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                              onPressed: () {
                                controller!.stop();
                                controller!.start();
                              },
                              child: const Text("Try Again", style: TextStyle(color: AppColors.whiteCommon),),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  color: AppColors.blackCommon,
                  child: const Center(
                    child: Text(
                      "Camera is off",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.whiteCommon,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          ),
        ),
        
        if (isActive)
          Positioned.fill(
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCorner(true, true),
                        _buildCorner(true, false),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCorner(false, true),
                        _buildCorner(false, false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildCorner(bool isTop, bool isLeft) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: AppColors.redCommon, width: 4) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: AppColors.redCommon, width: 4) : BorderSide.none,
          left: isLeft ? const BorderSide(color: AppColors.redCommon, width: 4) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: AppColors.redCommon, width: 4) : BorderSide.none,
        ),
      ),
    );
  }
}