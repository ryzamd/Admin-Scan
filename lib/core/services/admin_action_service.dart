// lib/core/services/admin_action_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../errors/exceptions.dart';
import '../services/secure_storage_service.dart';

/// Service for handling generic admin actions that follow the same pattern
/// but with different API endpoints and parameter names
class AdminActionService {
  final Dio dio;
  final SecureStorageService secureStorage;

  AdminActionService({
    required this.dio,
    required this.secureStorage,
  });

  /// Generic method to execute admin actions with configurable parameters
  ///
  /// [endpoint] - The API endpoint to call
  /// [codeParamName] - The name of the code parameter (e.g., "post_zc_code", "post_qc_code", etc.)
  /// [userNameParamName] - The name of the username parameter (e.g., "post_zc_UserName", "dele_qc_out_UserName", etc.)
  /// [code] - The actual code value to send
  /// [userName] - The actual username value to send
  Future<Map<String, dynamic>> executeAdminAction({
    required String endpoint,
    required String codeParamName,
    required String userNameParamName,
    required String code,
    required String userName,
  }) async {
    try {
      final token = await secureStorage.getAccessTokenAsync();
      
      final response = await dio.post(
        endpoint,
        data: {
          codeParamName: code,
          userNameParamName: userName,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
          contentType: 'application/json',
        ),
      );
      
      debugPrint('Admin action response code: ${response.statusCode}');
      debugPrint('Admin action response data: ${response.data}');
      
      if (response.statusCode == 200) {
        if (response.data['message'] == 'Success') {
          return response.data;
        } else {
          throw ServerException(response.data['message'] ?? 'Operation failed');
        }
      } else {
        throw ServerException('Server returned error code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('DioException in executeAdminAction: ${e.message}');
      throw ServerException(e.message ?? 'Network error');
    } catch (e) {
      debugPrint('Unexpected error in executeAdminAction: $e');
      throw ServerException(e.toString());
    }
  }
}