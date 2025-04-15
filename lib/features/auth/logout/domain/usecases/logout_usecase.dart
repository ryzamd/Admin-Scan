import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/errors/failures.dart';
import '../repositories/logout_repository.dart';

class LogoutUseCase {
  final LogoutRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      final result = await repository.logoutAsync();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}