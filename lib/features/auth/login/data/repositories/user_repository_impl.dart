import 'package:dartz/dartz.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_infor.dart';
import '../../../../../core/services/get_translate_key.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/login_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> loginUser({
    required String userId,
    required String password,
    required String name,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.loginUser(
          userId: userId,
          password: password,
          name: name,
        );
        
        return Right(user);
      } on ServerException catch (_) {
        return Left(ServerFailure(StringKey.serverErrorMessage));

      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(StringKey.networkErrorMessage));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> validateToken(String token) async {
    if (await networkInfo.isConnected) {
      try {

        final user = await remoteDataSource.validateToken(token);
        return Right(user);

      } on ServerException catch (_) {
        return Left(ServerFailure(StringKey.serverErrorMessage));

      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      }
    } else {
      return Left(ConnectionFailure(StringKey.networkErrorMessage));
    }
  }
}