import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../services/get_translate_key.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          case StringKey.calendarIconButton:
            onCalendarTap();
            break;
          case StringKey.refreshIconButton:
            onRefreshTap();
            break;
          case StringKey.torchIconButton:
            onTorchToggle();
            break;
          case StringKey.flipCameraIconButton:
            onCameraFlip();
            break;
          case StringKey.cameraToggleIconButton:
            onCameraToggle();
            break;
          case StringKey.clearIconButton:
            onClearData();
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        final multiLanguage = AppLocalizations.of(context);

        if (isDataView) {
          return [
            _buildPopupMenuItem(
              StringKey.calendarIconButton,
              Icons.calendar_month,
              multiLanguage.calendarIconButton,
              iconColor: AppColors.primary,
            ),
            _buildPopupMenuItem(
              StringKey.refreshIconButton,
              Icons.refresh,
              multiLanguage.refreshIconButton,
              iconColor: AppColors.primary,
            ),
          ];
        } else {
          return [
            _buildPopupMenuItem(
              StringKey.torchIconButton,
              isTorchEnabled ? Icons.flash_on : Icons.flash_off,
              multiLanguage.torchIconButton,
              iconColor: isTorchEnabled ? AppColors.warning : AppColors.primary,
            ),
            _buildPopupMenuItem(
              StringKey.flipCameraIconButton,
              Icons.flip_camera_ios,
              multiLanguage.flipCameraIconButton,
              iconColor: AppColors.primary,
            ),
            _buildPopupMenuItem(
              StringKey.cameraToggleIconButton,
              isCameraActive ? Icons.stop : Icons.play_arrow,
              multiLanguage.toggleCameraIconButton,
              iconColor: isCameraActive ? Colors.red : AppColors.primary,
            ),
            _buildPopupMenuItem(
              StringKey.clearIconButton,
              Icons.delete,
              multiLanguage.clearDataIconButton,
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