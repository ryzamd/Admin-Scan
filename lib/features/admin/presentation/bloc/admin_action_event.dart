import 'package:equatable/equatable.dart';

abstract class AdminActionEvent extends Equatable {
  const AdminActionEvent();

  @override
  List<Object> get props => [];
}

class InitializeScannerEvent extends AdminActionEvent {
  final dynamic controller;
  
  const InitializeScannerEvent(this.controller);
  
  @override
  List<Object> get props => [controller];
}

class ScanBarcodeEvent extends AdminActionEvent {
  final String barcode;

  const ScanBarcodeEvent(this.barcode);

  @override
  List<Object> get props => [barcode];
}

class HardwareScanEvent extends AdminActionEvent {
  final String scannedData;

  const HardwareScanEvent(this.scannedData);

  @override
  List<Object> get props => [scannedData];
}

class ClearScannedDataEvent extends AdminActionEvent {}

class ExecuteActionEvent extends AdminActionEvent {
  final String code;
  final String actionType;

  const ExecuteActionEvent({
    required this.code,
    required this.actionType,
  });

  @override
  List<Object> get props => [code, actionType];
}

class ClearWarehouseQtyIntEvent extends AdminActionEvent {
  final String code;

  const ClearWarehouseQtyIntEvent(this.code);

  @override
  List<Object> get props => [code];
}

class ClearQcInspectionDataEvent extends AdminActionEvent {
  final String code;

  const ClearQcInspectionDataEvent(this.code);

  @override
  List<Object> get props => [code];
}

class ClearQcDeductionCodeEvent extends AdminActionEvent {
  final String code;

  const ClearQcDeductionCodeEvent(this.code);

  @override
  List<Object> get props => [code];
}

class PullQcUncheckedDataEvent extends AdminActionEvent {
  final String code;

  const PullQcUncheckedDataEvent(this.code);

  @override
  List<Object> get props => [code];
}

class ClearAllDataEvent extends AdminActionEvent {
  final String code;

  const ClearAllDataEvent(this.code);

  @override
  List<Object> get props => [code];
}