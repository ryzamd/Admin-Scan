import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppBarActionsButton extends StatelessWidget {
  final bool isDataView;
  final bool isCameraActive;
  final bool isTorchEnabled;
  final VoidCallback onCalendarTap;
  final VoidCallback onRefreshTap;
  final VoidCallback onTorchToggle;
  final VoidCallback onCameraFlip;
  final VoidCallback onCameraToggle;
  final VoidCallback onClearData;

  const AppBarActionsButton({
    super.key,
    required this.isDataView,
    this.isCameraActive = false,
    this.isTorchEnabled = false,
    required this.onCalendarTap,
    required this.onRefreshTap,
    required this.onTorchToggle,
    required this.onCameraFlip,
    required this.onCameraToggle,
    required this.onClearData,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.view_quilt, color: Colors.white),
      onSelected: (String value) {
        switch (value) {
          case 'calendar':
            onCalendarTap();
            break;
          case 'refresh':
            onRefreshTap();
            break;
          case 'torch':
            onTorchToggle();
            break;
          case 'flip_camera':
            onCameraFlip();
            break;
          case 'camera_toggle':
            onCameraToggle();
            break;
          case 'clear':
            onClearData();
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        if (isDataView) {
          return [
            _buildPopupMenuItem(
              'calendar',
              Icons.calendar_month,
              'Calendar',
              iconColor: AppColors.primary,
            ),
            _buildPopupMenuItem(
              'refresh',
              Icons.refresh,
              'Refresh',
              iconColor: AppColors.primary,
            ),
          ];
        } else {
          return [
            _buildPopupMenuItem(
              'torch',
              isTorchEnabled ? Icons.flash_on : Icons.flash_off,
              'Torch',
              iconColor: isTorchEnabled ? AppColors.warning : AppColors.primary,
            ),
            _buildPopupMenuItem(
              'flip_camera',
              Icons.flip_camera_ios,
              'Flip Camera',
              iconColor: AppColors.primary,
            ),
            _buildPopupMenuItem(
              'camera_toggle',
              isCameraActive ? Icons.stop : Icons.play_arrow,
              'Toggle Camera',
              iconColor: isCameraActive ? Colors.red : AppColors.primary,
            ),
            _buildPopupMenuItem(
              'clear',
              Icons.delete,
              'Clear Data',
              iconColor: Colors.red,
            ),
          ];
        }
      },
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    IconData icon,
    String text,
    {Color? iconColor,}
  ) {
    return PopupMenuItem<String>(
      value: value,
      child:  Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Icon(icon, color: iconColor),
          ),
          Text(text),
        ],
      ),
    );
  }
}