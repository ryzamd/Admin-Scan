import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class ExitConfirmationDialog extends StatelessWidget {
  static bool _isShowing = false;
  
  final VoidCallback? onCancel;
  
  const ExitConfirmationDialog({
    super.key,
    this.onCancel,
  });
  
  static Future<void> showAsync(BuildContext context) async {
    if (!_isShowing && context.mounted) {
      _isShowing = true;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ExitConfirmationDialog(
          onCancel: () => Navigator.of(context).pop(),
        ),
      ).then((_) {
        _isShowing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'EXIT',
        style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: const Text('Are you sure to exit the application?'),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: AppColors.blackCommon, fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: const Text('OK', style: TextStyle(color: AppColors.error, fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}