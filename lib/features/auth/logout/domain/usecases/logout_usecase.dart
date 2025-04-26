import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/get_translate_key.dart';
import '../repositories/logout_repository.dart';

class LogoutUseCase {
  final LogoutRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      final result = await repository.logoutAsync();
      return Right(result);
    } catch (_) {
      return Left(ServerFailure(StringKey.serverErrorMessage));
    }
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}