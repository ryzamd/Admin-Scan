import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TranslateKey {
  static String getStringKey(AppLocalizations l10n, String key) {
    switch (key) {
      case StringKey.serverErrorMessage:
        return l10n.serverErrorMessage;

      case StringKey.networkErrorMessage:
        return l10n.networkErrorMessage;

      case StringKey.confirmButtonDialog:
        return l10n.confirmButtonDialog;

      case StringKey.logoutButtonUPCASE:
        return l10n.logoutButtonUPCASE;

      case StringKey.cancelButtonDialog:
        return l10n.cancelButtonDialog;

      case StringKey.cancelButton:
        return l10n.cancelButton;

      default:
        return 'Cannot find String key';
    }
  }
}

class StringKey {
  static const String serverErrorMessage = "serverErrorMessage";
  static const String networkErrorMessage = "networkErrorMessage";

  static const String calendarIconButton = "calendarIconButton";
  static const String refreshIconButton = "refreshIconButton";
  static const String torchIconButton = "torchIconButton";
  static const String flipCameraIconButton = "flipCameraIconButton";
  static const String cameraToggleIconButton = "cameraToggleIconButton";
  static const String clearIconButton = "clearIconButton";

  static const String confirmButtonDialog = "confirmButtonDialog";
  static const String logoutButtonUPCASE = "logoutButtonUPCASE";
  static const String cancelButtonDialog = "cancelButtonDialog";
  static const String cancelButton = "cancelButton";
}

class FunctionType {
  static const String ACTION_CLEAR_WAREHOUSE_QTY = 'clear_warehouse_qty';
  static const String ACTION_CLEAR_QC_INSPECTION = 'clear_qc_inspection';
  static const String ACTION_CLEAR_QC_DEDUCTION = 'clear_qc_deduction';
  static const String ACTION_PULL_QC_UNCHECKED = 'pull_qc_unchecked';
  static const String ACTION_CLEAR_ALL_DATA = 'clear_all_data';
}