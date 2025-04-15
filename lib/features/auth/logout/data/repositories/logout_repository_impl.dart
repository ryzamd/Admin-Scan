import 'package:flutter/material.dart';
import '../../../../../core/auth/auth_repository.dart';
import '../../../../../core/di/dependencies.dart' as di;
import '../datasources/logout_datasource.dart';
import '../../domain/repositories/logout_repository.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutDataSource dataSource;

  LogoutRepositoryImpl({required this.dataSource});

  @override
  Future<bool> logoutAsync() async {
    try {
      return await di.sl<AuthRepository>().logoutAsync();

    } catch (e) {
      debugPrint('Error during logout: $e');
      return false;
    }
  }
}