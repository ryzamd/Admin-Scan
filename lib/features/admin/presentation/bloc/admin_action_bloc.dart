import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/services/get_translate_key.dart';
import '../../../../main.dart' as global;
import '../../../auth/login/domain/entities/user_entity.dart';
import '../../domain/usecases/check_code.dart';
import '../../domain/usecases/execute_admin_action.dart';
import 'admin_action_event.dart';
import 'admin_action_state.dart';

class AdminActionBloc extends Bloc<AdminActionEvent, AdminActionState> {
  final ExecuteAdminAction executeAdminAction;
  final ClearWarehouseQtyInt clearWarehouseQtyInt;
  final ClearQcInspectionData clearQcInspectionData;
  final ClearQcDeductionCode clearQcDeductionCode;
  final PullQcUncheckedData pullQcUncheckedData;
  final ClearAllData clearAllData;
  final InternetConnectionChecker connectionChecker;
  final UserEntity currentUser;
  final CheckCode checkCode;
  
  MobileScannerController? scannerController;

  AdminActionBloc({
    required this.executeAdminAction,
    required this.clearWarehouseQtyInt,
    required this.clearQcInspectionData,
    required this.clearQcDeductionCode,
    required this.pullQcUncheckedData,
    required this.clearAllData,
    required this.connectionChecker,
    required this.currentUser,
    required this.checkCode,
  }) : super(AdminActionInitial()) {
    on<InitializeScannerEvent>(_onInitializeScanner);
    on<ScanBarcodeEvent>(_onScanBarcode);
    on<HardwareScanEvent>(_onHardwareScan);
    on<ClearScannedDataEvent>(_onClearScannedData);
    on<ExecuteActionEvent>(_onExecuteAction);
    on<ClearWarehouseQtyIntEvent>(_onClearWarehouseQtyInt);
    on<ClearQcInspectionDataEvent>(_onClearQcInspectionData);
    on<ClearQcDeductionCodeEvent>(_onClearQcDeductionCode);
    on<PullQcUncheckedDataEvent>(_onPullQcUncheckedData);
    on<ClearAllDataEvent>(_onClearAllData);
    on<CheckCodeEvent>(_onCheckCode);
    
    connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        debugPrint('Internet connection lost!');
      }
    });
  }
  
  void _onInitializeScanner(
    InitializeScannerEvent event,
    Emitter<AdminActionState> emit,
  ) {
    debugPrint('Initializing scanner controller');
    
    scannerController = event.controller as MobileScannerController;
    
    emit(AdminActionScanning(
      isCameraActive: true,
      isTorchEnabled: false,
      controller: scannerController,
    ));
  }
  
  void _onScanBarcode(
    ScanBarcodeEvent event,
    Emitter<AdminActionState> emit,
  ) {
    debugPrint('Barcode scanned: ${event.barcode}');
    
    emit(AdminActionCodeScanned(event.barcode));

    add(CheckCodeEvent(event.barcode));
  }
  
  void _onHardwareScan(
    HardwareScanEvent event,
    Emitter<AdminActionState> emit,
  ) {
    debugPrint('Hardware scan detected: ${event.scannedData}');
    
    emit(AdminActionCodeScanned(event.scannedData));

    add(CheckCodeEvent(event.scannedData));
  }
  
  void _onClearScannedData(
    ClearScannedDataEvent event,
    Emitter<AdminActionState> emit,
  ) {
    if (state is AdminActionScanning) {
      emit((state as AdminActionScanning).copyWith());
    } else {
      emit(AdminActionScanning(
        isCameraActive: true,
        isTorchEnabled: false,
        controller: scannerController,
      ));
    }
  }
  
  Future<void> _onExecuteAction(
    ExecuteActionEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    debugPrint('Executing admin action: ${event.actionType} for code: ${event.code}');
    
    if (!(await connectionChecker.hasConnection)) {
      emit(AdminActionError(
        message: StringKey.networkErrorMessage,
        previousState: state,
      ));
      return;
    }
    
    emit(AdminActionProcessing(
      code: event.code,
      actionType: event.actionType,
    ));
    
    switch (event.actionType) {
      case FunctionType.ACTION_CLEAR_WAREHOUSE_QTY:
        await _executeClearWarehouseQtyInt(event.code, emit);
        break;
      case FunctionType.ACTION_CLEAR_QC_INSPECTION:
        await _executeClearQcInspectionData(event.code, emit);
        break;
      case FunctionType.ACTION_CLEAR_QC_DEDUCTION:
        await _executeClearQcDeductionCode(event.code, emit);
        break;
      case FunctionType.ACTION_PULL_QC_UNCHECKED:
        await _executePullQcUncheckedData(event.code, emit);
        break;
      case FunctionType.ACTION_CLEAR_ALL_DATA:
        await _executeClearAllData(event.code, emit);
        break;
      default:
        emit(AdminActionError(
          message: 'Unknown action type: ${event.actionType}',
          previousState: state,
        ));
    }
  }
  
  Future<void> _executeClearWarehouseQtyInt(String code, Emitter<AdminActionState> emit) async {
    final result = await clearWarehouseQtyInt(
      CodeAndUserParams(
        code: code,
        userName: currentUser.name,
      ),
    );
    
    result.fold(
      (failure) {
        emit(AdminActionError(
          message: failure.message,
          previousState: state,
        ));
      },
      (data) {
        emit(AdminActionSuccess(
          result: data,
          actionType: FunctionType.ACTION_CLEAR_WAREHOUSE_QTY,
        ));
      },
    );
  }
  
  Future<void> _executeClearQcInspectionData(String code, Emitter<AdminActionState> emit) async {
    final result = await clearQcInspectionData(
      CodeAndUserParams(
        code: code,
        userName: currentUser.name,
      ),
    );
    
    result.fold(
      (failure) {
        emit(AdminActionError(
          message: failure.message,
          previousState: state,
        ));
      },
      (data) {
        emit(AdminActionSuccess(
          result: data,
          actionType: FunctionType.ACTION_CLEAR_QC_INSPECTION,
        ));
      },
    );
  }
  
  Future<void> _executeClearQcDeductionCode(String code, Emitter<AdminActionState> emit) async {
    final result = await clearQcDeductionCode(
      CodeAndUserParams(
        code: code,
        userName: currentUser.name,
      ),
    );
    
    result.fold(
      (failure) {
        emit(AdminActionError(
          message: failure.message,
          previousState: state,
        ));
      },
      (data) {
        emit(AdminActionSuccess(
          result: data,
          actionType: FunctionType.ACTION_CLEAR_QC_DEDUCTION,
        ));
      },
    );
  }
  
  Future<void> _executePullQcUncheckedData(String code, Emitter<AdminActionState> emit) async {
    final result = await pullQcUncheckedData(
      CodeAndUserParams(
        code: code,
        userName: currentUser.name,
      ),
    );
    
    result.fold(
      (failure) {
        emit(AdminActionError(
          message: failure.message,
          previousState: state,
        ));
      },
      (data) {
        emit(AdminActionSuccess(
          result: data,
          actionType: FunctionType.ACTION_PULL_QC_UNCHECKED,
        ));
      },
    );
  }
  
  Future<void> _executeClearAllData(String code, Emitter<AdminActionState> emit) async {
    final result = await clearAllData(
      CodeAndUserParams(
        code: code,
        userName: currentUser.name,
      ),
    );
    
    result.fold(
      (failure) {
        emit(AdminActionError(
          message: failure.message,
          previousState: state,
        ));
      },
      (data) {
        emit(AdminActionSuccess(
          result: data,
          actionType: FunctionType.ACTION_CLEAR_ALL_DATA,
        ));
      },
    );
  }
  
  Future<void> _onClearWarehouseQtyInt(
    ClearWarehouseQtyIntEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: FunctionType.ACTION_CLEAR_WAREHOUSE_QTY,
    ));
  }
  
  Future<void> _onClearQcInspectionData(
    ClearQcInspectionDataEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: FunctionType.ACTION_CLEAR_QC_INSPECTION,
    ));
  }
  
  Future<void> _onClearQcDeductionCode(
    ClearQcDeductionCodeEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: FunctionType.ACTION_CLEAR_QC_DEDUCTION,
    ));
  }
  
  Future<void> _onPullQcUncheckedData(
    PullQcUncheckedDataEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: FunctionType.ACTION_PULL_QC_UNCHECKED,
    ));
  }
  
  Future<void> _onClearAllData(
    ClearAllDataEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: FunctionType.ACTION_CLEAR_ALL_DATA,
    ));
  }
  
  @override
  Future<void> close() {
    scannerController?.dispose();
    return super.close();
  }

  Future<void> _onCheckCode(
    CheckCodeEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    debugPrint('Checking code: ${event.code}');
    
    if (!(await connectionChecker.hasConnection)) {
      emit(AdminActionError(
        message: StringKey.networkErrorMessage,
        previousState: state,
      ));
      return;
    }
    
    
    final result = await checkCode(
      CheckCodeParams(
        code: event.code,
        userName: currentUser.name,
      ),
    );
    
    result.fold(
      (failure) {
        emit(AdminActionError(
          message: failure.message,
          previousState: state,
        ));
      },
      (data) {
        String actionType = '';
        
        if (state is AdminActionScanning) {
          final route = ModalRoute.of(global.navigatorKey.currentContext!)?.settings.name;
          
          if (route?.contains(FunctionType.ACTION_CLEAR_WAREHOUSE_QTY) ?? false) {
            actionType = FunctionType.ACTION_CLEAR_WAREHOUSE_QTY;

          } else if (route?.contains(FunctionType.ACTION_CLEAR_QC_INSPECTION) ?? false) {
            actionType = FunctionType.ACTION_CLEAR_QC_INSPECTION;

          } else if (route?.contains(FunctionType.ACTION_CLEAR_QC_DEDUCTION) ?? false) {
            actionType = FunctionType.ACTION_CLEAR_QC_DEDUCTION;

          } else if (route?.contains(FunctionType.ACTION_PULL_QC_UNCHECKED) ?? false) {
            actionType = FunctionType.ACTION_PULL_QC_UNCHECKED;

          } else if (route?.contains(FunctionType.ACTION_CLEAR_ALL_DATA) ?? false) {
            actionType = FunctionType.ACTION_CLEAR_ALL_DATA;
          }
        }
        
        emit(AdminActionDataLoaded(
          data: data,
          actionType: actionType,
        ));
      },
    );
  }
}