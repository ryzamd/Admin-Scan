import 'package:equatable/equatable.dart';
import '../../domain/entities/admin_action_entity.dart';
import '../../domain/entities/scanned_data_entity.dart';

abstract class AdminActionState extends Equatable {
  const AdminActionState();

  @override
  List<Object?> get props => [];
}

class AdminActionInitial extends AdminActionState {}

class AdminActionScanning extends AdminActionState {
  final bool isCameraActive;
  final bool isTorchEnabled;
  final dynamic controller;

  const AdminActionScanning({
    required this.isCameraActive,
    required this.isTorchEnabled,
    this.controller,
  });

  @override
  List<Object?> get props => [isCameraActive, isTorchEnabled, controller];

  AdminActionScanning copyWith({
    bool? isCameraActive,
    bool? isTorchEnabled,
    dynamic controller,
  }) {
    return AdminActionScanning(
      isCameraActive: isCameraActive ?? this.isCameraActive,
      isTorchEnabled: isTorchEnabled ?? this.isTorchEnabled,
      controller: controller ?? this.controller,
    );
  }
}

class AdminActionCodeScanned extends AdminActionState {
  final String code;

  const AdminActionCodeScanned(this.code);

  @override
  List<Object> get props => [code];
}

class AdminActionProcessing extends AdminActionState {
  final String code;
  final String actionType;

  const AdminActionProcessing({
    required this.code,
    required this.actionType,
  });

  @override
  List<Object> get props => [code, actionType];
}

class AdminActionSuccess extends AdminActionState {
  final AdminActionEntity result;
  final String actionType;

  const AdminActionSuccess({
    required this.result,
    required this.actionType,
  });

  @override
  List<Object> get props => [result, actionType];
}

class AdminActionError extends AdminActionState {
  final String message;
  final AdminActionState previousState;

  const AdminActionError({
    required this.message,
    required this.previousState,
  });

  @override
  List<Object> get props => [message, previousState];
}

class AdminActionDataLoading extends AdminActionState {
  final String code;
  
  const AdminActionDataLoading(this.code);
  
  @override
  List<Object> get props => [code];
}

class AdminActionDataLoaded extends AdminActionState {
  final ScannedDataEntity data;
  final String actionType;
  
  const AdminActionDataLoaded({
    required this.data,
    required this.actionType,
  });
  
  @override
  List<Object> get props => [data, actionType];
}