import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/exit_confirmation_dialog.dart';

class BackButtonService {

  static final BackButtonService _instance = BackButtonService._internal();
  factory BackButtonService() => _instance;
  BackButtonService._internal();


  static const EventChannel _eventChannel = EventChannel(
    'com.example.warehouse_scan/back_button',
  );

  StreamSubscription? _subscription;

  void initialize(BuildContext context) {
    _subscription?.cancel();
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      (_) {
        if (context.mounted) {
          ExitConfirmationDialog.showAsync(context);
        }
      },
    );
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
