import 'package:admin_scan/core/services/get_translate_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  static bool _isShowing = false;
  
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final Color confirmColor;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = StringKey.confirmButtonDialog,
    this.cancelText = StringKey.cancelButtonDialog,
    required this.onConfirm,
    required this.onCancel,
    this.confirmColor = AppColors.success,
  });
  
  static Future<void> showAsync(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = StringKey.confirmButtonDialog,
    String cancelText = StringKey.cancelButtonDialog,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    Color confirmColor = AppColors.success,
  }) async {
    
    final multiLanguage = AppLocalizations.of(context);

    if (!_isShowing && context.mounted) {
      _isShowing = true;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ConfirmationDialog(
          title: title,
          message: message,
          confirmText: TranslateKey.getStringKey(multiLanguage, confirmText),
          cancelText: TranslateKey.getStringKey(multiLanguage, cancelText),
          onConfirm: () {
            _isShowing = false;
            Navigator.pop(context);
            onConfirm();
          },
          onCancel: () {
            _isShowing = false;
            Navigator.pop(context);
            onCancel();
          },
          confirmColor: confirmColor,
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
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.alert,
          fontSize: 18,
        ),
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            onCancel();
          },
          child: Text(
            cancelText,
            style: const TextStyle(
              color: AppColors.buttonCancel,
              fontSize: 14,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.scaffoldBackground,
            backgroundColor: confirmColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          child: Text(
            confirmText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}