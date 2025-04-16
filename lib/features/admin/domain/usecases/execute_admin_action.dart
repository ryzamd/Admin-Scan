import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/admin_action_entity.dart';
import '../repositories/admin_action_repository.dart';

class ExecuteAdminAction {
  final AdminActionRepository repository;

  ExecuteAdminAction(this.repository);

  Future<Either<Failure, AdminActionEntity>> call(AdminActionParams params) async {
    return await repository.executeAction(
      endpoint: params.endpoint,
      codeParamName: params.codeParamName,
      userNameParamName: params.userNameParamName,
      code: params.code,
      userName: params.userName,
    );
  }
}

class AdminActionParams extends Equatable {
  final String endpoint;
  final String codeParamName;
  final String userNameParamName;
  final String code;
  final String userName;

  const AdminActionParams({
    required this.endpoint,
    required this.codeParamName,
    required this.userNameParamName,
    required this.code,
    required this.userName,
  });

  @override
  List<Object> get props => [endpoint, codeParamName, userNameParamName, code, userName];
}

class ClearWarehouseQtyInt {
  final AdminActionRepository repository;

  ClearWarehouseQtyInt(this.repository);

  Future<Either<Failure, AdminActionEntity>> call(CodeAndUserParams params) async {
    return await repository.clearWarehouseQtyInt(params.code, params.userName);
  }
}

class ClearQcInspectionData {
  final AdminActionRepository repository;

  ClearQcInspectionData(this.repository);

  Future<Either<Failure, AdminActionEntity>> call(CodeAndUserParams params) async {
    return await repository.clearQcInspectionData(params.code, params.userName);
  }
}

class ClearQcDeductionCode {
  final AdminActionRepository repository;

  ClearQcDeductionCode(this.repository);

  Future<Either<Failure, AdminActionEntity>> call(CodeAndUserParams params) async {
    return await repository.clearQcDeductionCode(params.code, params.userName);
  }
}

class PullQcUncheckedData {
  final AdminActionRepository repository;

  PullQcUncheckedData(this.repository);

  Future<Either<Failure, AdminActionEntity>> call(CodeAndUserParams params) async {
    return await repository.pullQcUncheckedData(params.code, params.userName);
  }
}

class ClearAllData {
  final AdminActionRepository repository;

  ClearAllData(this.repository);

  Future<Either<Failure, AdminActionEntity>> call(CodeAndUserParams params) async {
    return await repository.clearAllData(params.code, params.userName);
  }
}

class CodeAndUserParams extends Equatable {
  final String code;
  final String userName;

  const CodeAndUserParams({
    required this.code,
    required this.userName,
  });

  @override
  List<Object> get props => [code, userName];
}