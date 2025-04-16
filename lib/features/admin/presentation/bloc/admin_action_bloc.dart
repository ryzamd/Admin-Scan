// lib/features/admin/presentation/bloc/admin_action_bloc.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../auth/login/domain/entities/user_entity.dart';
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
  
  MobileScannerController? scannerController;

  static const String ACTION_CLEAR_WAREHOUSE_QTY = 'clear_warehouse_qty';
  static const String ACTION_CLEAR_QC_INSPECTION = 'clear_qc_inspection';
  static const String ACTION_CLEAR_QC_DEDUCTION = 'clear_qc_deduction';
  static const String ACTION_PULL_QC_UNCHECKED = 'pull_qc_unchecked';
  static const String ACTION_CLEAR_ALL_DATA = 'clear_all_data';

  AdminActionBloc({
    required this.executeAdminAction,
    required this.clearWarehouseQtyInt,
    required this.clearQcInspectionData,
    required this.clearQcDeductionCode,
    required this.pullQcUncheckedData,
    required this.clearAllData,
    required this.connectionChecker,
    required this.currentUser,
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
  }
  
  void _onHardwareScan(
    HardwareScanEvent event,
    Emitter<AdminActionState> emit,
  ) {
    debugPrint('Hardware scan detected: ${event.scannedData}');
    
    emit(AdminActionCodeScanned(event.scannedData));
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
        message: 'No internet connection. Please check your network.',
        previousState: state,
      ));
      return;
    }
    
    emit(AdminActionProcessing(
      code: event.code,
      actionType: event.actionType,
    ));
    
    switch (event.actionType) {
      case ACTION_CLEAR_WAREHOUSE_QTY:
        await _executeClearWarehouseQtyInt(event.code, emit);
        break;
      case ACTION_CLEAR_QC_INSPECTION:
        await _executeClearQcInspectionData(event.code, emit);
        break;
      case ACTION_CLEAR_QC_DEDUCTION:
        await _executeClearQcDeductionCode(event.code, emit);
        break;
      case ACTION_PULL_QC_UNCHECKED:
        await _executePullQcUncheckedData(event.code, emit);
        break;
      case ACTION_CLEAR_ALL_DATA:
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
          actionType: ACTION_CLEAR_WAREHOUSE_QTY,
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
          actionType: ACTION_CLEAR_QC_INSPECTION,
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
          actionType: ACTION_CLEAR_QC_DEDUCTION,
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
          actionType: ACTION_PULL_QC_UNCHECKED,
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
          actionType: ACTION_CLEAR_ALL_DATA,
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
      actionType: ACTION_CLEAR_WAREHOUSE_QTY,
    ));
  }
  
  Future<void> _onClearQcInspectionData(
    ClearQcInspectionDataEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: ACTION_CLEAR_QC_INSPECTION,
    ));
  }
  
  Future<void> _onClearQcDeductionCode(
    ClearQcDeductionCodeEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: ACTION_CLEAR_QC_DEDUCTION,
    ));
  }
  
  Future<void> _onPullQcUncheckedData(
    PullQcUncheckedDataEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: ACTION_PULL_QC_UNCHECKED,
    ));
  }
  
  Future<void> _onClearAllData(
    ClearAllDataEvent event,
    Emitter<AdminActionState> emit,
  ) async {
    add(ExecuteActionEvent(
      code: event.code,
      actionType: ACTION_CLEAR_ALL_DATA,
    ));
  }
  
  @override
  Future<void> close() {
    scannerController?.dispose();
    return super.close();
  }
}