import 'package:admin_scan/core/constants/api_constants.dart';
import 'package:admin_scan/core/services/secure_storage_service.dart';
import 'package:admin_scan/features/home_data/data/models/home_data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/dependencies.dart' as di;
import '../../../../core/errors/exceptions.dart';

abstract class HomeDataRemoteDataSource {
  Future<List<HomeDataModel>> getHomeDataAsync(String date);
}

class HomeDataRemoteDataSourceImpl implements HomeDataRemoteDataSource {
  final Dio dio;
  final SecureStorageService secureStorageService;

  HomeDataRemoteDataSourceImpl({required this.dio, required this.secureStorageService});
  
  @override
  Future<List<HomeDataModel>> getHomeDataAsync(String date) async {
    try {
      final token = await di.sl<SecureStorageService>().getAccessTokenAsync();
      
      final response = await dio.get(
        ApiConstants.getListUrl(date),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          contentType: Headers.jsonContentType,
        )
      );

      debugPrint('Home data API response code: ${response.statusCode}');
      debugPrint('Home data API response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        final List<dynamic> itemJson = response.data;

        final result = itemJson.map((e) => HomeDataModel.fromJson(e)).toList();

        return result;

      } else {
        throw ServerException('Failed to load home data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('DioException in getHomeData: ${e.message}');
      debugPrint('Request path: ${e.requestOptions.path}');
      debugPrint('Request data: ${e.requestOptions.data}');
      throw ServerException(e.message ?? 'Error fetching home data');
    } catch (e) {
      debugPrint('Unexpected error in getHomeData: $e');
      throw ServerException(e.toString());
    }
  }
}