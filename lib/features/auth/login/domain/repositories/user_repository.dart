import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {

  Future<Either<Failure, UserEntity>> loginUser({
    required String userId,
    required String password,
    required String name,
  });
  
  Future<Either<Failure, UserEntity>> validateToken(String token);
}