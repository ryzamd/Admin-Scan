// lib/features/admin/data/datasources/admin_action_datasource.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/admin_action_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../models/admin_action_model.dart';

abstract class AdminActionDataSource {
  /// Execute an admin action with the given parameters
  ///
  /// Throws [ServerException] if any error occurs
  Future<AdminActionModel> executeAction({
    required String endpoint,
    required String codeParamName,
    required String userNameParamName,
    required String code,
    required String userName,
  });

   Future<AdminActionModel> clearWarehouseQtyInt(String code, String userName);
   Future<AdminActionModel> clearQcInspectionData(String code, String userName);
   Future<AdminActionModel> clearQcDeductionCode(String code, String userName);
   Future<AdminActionModel> pullQcUncheckedData(String code, String userName);
   Future<AdminActionModel> clearAllData(String code, String userName);
}

class AdminActionDataSourceImpl implements AdminActionDataSource {
  final Dio dio;
  final SecureStorageService secureStorage;
  final AdminActionService adminService;

  AdminActionDataSourceImpl({
    required this.dio,
    required this.secureStorage,
    required this.adminService,
  });

  @override
  Future<AdminActionModel> executeAction({
    required String endpoint,
    required String codeParamName,
    required String userNameParamName,
    required String code,
    required String userName,
  }) async {
    try {
      debugPrint('Executing admin action: $endpoint');
      
      final result = await adminService.executeAdminAction(
        endpoint: endpoint,
        codeParamName: codeParamName,
        userNameParamName: userNameParamName,
        code: code,
        userName: userName,
      );
      
      return AdminActionModel.fromJson(result);
    } catch (e) {
      debugPrint('Error in executeAction: $e');
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<AdminActionModel> clearWarehouseQtyInt(String code, String userName) async {
    return executeAction(
      endpoint: ApiConstants.clearIncomingDataUrl,
      codeParamName: 'post_zc_code',
      userNameParamName: 'post_zc_UserName',
      code: code,
      userName: userName,
    );
  }
  
  @override
  Future<AdminActionModel> clearQcInspectionData(String code, String userName) async {
    return executeAction(
      endpoint: ApiConstants.clearQcInspectionDataUrl,
      codeParamName: 'post_qc_code',
      userNameParamName: 'dele_qc_int_out_UserName',
      code: code,
      userName: userName,
    );
  }
  
  @override
  Future<AdminActionModel> clearQcDeductionCode(String code, String userName) async {
    return executeAction(
      endpoint: ApiConstants.clearQcDeductionUrl,
      codeParamName: 'post_qc_code',
      userNameParamName: 'dele_qc_out_UserName',
      code: code,
      userName: userName,
    );
  }
  
  @override
  Future<AdminActionModel> pullQcUncheckedData(String code, String userName) async {
    return executeAction(
      endpoint: ApiConstants.pullQcUncheckedDataUrl,
      codeParamName: 'zc_pull_qty_code',
      userNameParamName: 'zc_pull_qty_UserName',
      code: code,
      userName: userName,
    );
  }
  
  @override
  Future<AdminActionModel> clearAllData(String code, String userName) async {
    return executeAction(
      endpoint: ApiConstants.clearAllDataUrl,
      codeParamName: 'All_code',
      userNameParamName: 'All_UserName',
      code: code,
      userName: userName,
    );
  }
}