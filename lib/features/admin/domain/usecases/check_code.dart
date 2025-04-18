import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/scanned_data_entity.dart';
import '../repositories/admin_action_repository.dart';

class CheckCode {
  final AdminActionRepository repository;

  CheckCode(this.repository);

  Future<Either<Failure, ScannedDataEntity>> call(CheckCodeParams params) async {
    return await repository.checkCode(params.code, params.userName);
  }
}

class CheckCodeParams extends Equatable {
  final String code;
  final String userName;

  const CheckCodeParams({
    required this.code,
    required this.userName,
  });

  @override
  List<Object> get props => [code, userName];
}