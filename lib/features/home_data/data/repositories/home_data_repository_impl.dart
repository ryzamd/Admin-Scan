import 'package:admin_scan/core/errors/failures.dart';
import 'package:admin_scan/core/network/network_infor.dart';
import 'package:admin_scan/features/home_data/data/datasources/home_data_remote_datasource.dart';
import 'package:admin_scan/features/home_data/domain/entities/home_data_entity.dart';
import 'package:admin_scan/features/home_data/domain/repositories/home_data_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/services/get_translate_key.dart';

class HomeDataRepositoryImpl implements HomeDataRepository{
  final NetworkInfo networkInfo;
  final HomeDataRemoteDataSource homeDataRemoteDatasource;

  HomeDataRepositoryImpl({
    required this.homeDataRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<HomeDataEntity>>> getHomeDataAsync(String date) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await homeDataRemoteDatasource.getHomeDataAsync(date);

        return Right(result);

      } catch (_) {
        return Left(ServerFailure(StringKey.serverErrorMessage));
      }
    } else {
      return Left(ConnectionFailure(StringKey.networkErrorMessage));
    }
    
  }
}