// lib/features/admin/data/datasources/admin_action_datasource.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/admin_action_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../models/admin_action_model.dart';
import '../models/check_code_response.dart';
import '../models/scanned_data_model.dart';

abstract class AdminActionDataSource {
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
   Future<ScannedDataModel> checkCode(String code, String userName);
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
  
  @override
  Future<ScannedDataModel> checkCode(String code, String userName) async {
    try {
      final response = await dio.post(
        ApiConstants.checkCodeUrl,
        data: {
          'code': code,
          'user_name': userName,
        },
      );
      
      debugPrint('Check code response: ${response.statusCode}, ${response.data}');
      
      if (response.statusCode == 200) {
        if (response.data['message'] == 'Success') {
          final checkCodeResponse = CheckCodeResponse.fromJson(response.data);
          return checkCodeResponse.data;
        } else {
          throw ServerException(response.data['message'] ?? 'Failed to check code');
        }
      } else {
        throw ServerException('Server returned error code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('DioException in checkCode: ${e.message}');
      throw ServerException('Network error');
    } catch (e) {
      debugPrint('Unexpected error in checkCode: $e');
      throw ServerException(e.toString());
    }
  }
}