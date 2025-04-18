// lib/features/admin/data/repositories/admin_action_repository_impl.dart
import 'package:admin_scan/features/admin/domain/entities/scanned_data_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_infor.dart';
import '../../domain/entities/admin_action_entity.dart';
import '../../domain/repositories/admin_action_repository.dart';
import '../datasources/admin_action_datasource.dart';

class AdminActionRepositoryImpl implements AdminActionRepository {
  final AdminActionDataSource dataSource;
  final NetworkInfo networkInfo;

  AdminActionRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AdminActionEntity>> executeAction({
    required String endpoint,
    required String codeParamName,
    required String userNameParamName,
    required String code,
    required String userName,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.executeAction(
          endpoint: endpoint,
          codeParamName: codeParamName,
          userNameParamName: userNameParamName,
          code: code,
          userName: userName,
        );
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure('No internet connection. Please check your network settings and try again.'));
    }
  }
  
  @override
  Future<Either<Failure, AdminActionEntity>> clearWarehouseQtyInt(String code, String userName) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.clearWarehouseQtyInt(code, userName);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure('No internet connection. Please check your network settings and try again.'));
    }
  }
  
  @override
  Future<Either<Failure, AdminActionEntity>> clearQcInspectionData(String code, String userName) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.clearQcInspectionData(code, userName);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure('No internet connection. Please check your network settings and try again.'));
    }
  }
  
  @override
  Future<Either<Failure, AdminActionEntity>> clearQcDeductionCode(String code, String userName) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.clearQcDeductionCode(code, userName);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure('No internet connection. Please check your network settings and try again.'));
    }
  }
  
  @override
  Future<Either<Failure, AdminActionEntity>> pullQcUncheckedData(String code, String userName) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.pullQcUncheckedData(code, userName);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure('No internet connection. Please check your network settings and try again.'));
    }
  }
  
  @override
  Future<Either<Failure, AdminActionEntity>> clearAllData(String code, String userName) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.clearAllData(code, userName);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ConnectionFailure('No internet connection. Please check your network settings and try again.'));
    }
  }

  @override
  Future<Either<Failure, ScannedDataEntity>> checkCode(String code, String userName) async {
    if (await networkInfo.isConnected) {
      try {

        final result = await dataSource.checkCode(code, userName);
        debugPrint('Check code result: $result');
        return Right(result);

      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));

      } catch (e) {
        return Left(ServerFailure(e.toString()));
        
      }
    } else {
      return Left(ConnectionFailure('No internet connection. Please check your network settings and try again.'));
    }
  }
}