import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/admin_action_entity.dart';

abstract class AdminActionRepository {
  Future<Either<Failure, AdminActionEntity>> executeAction({
    required String endpoint,
    required String codeParamName,
    required String userNameParamName,
    required String code,
    required String userName,
  });
  
  Future<Either<Failure, AdminActionEntity>> clearWarehouseQtyInt(String code, String userName);
  
  Future<Either<Failure, AdminActionEntity>> clearQcInspectionData(String code, String userName);
  
  Future<Either<Failure, AdminActionEntity>> clearQcDeductionCode(String code, String userName);
  
  Future<Either<Failure, AdminActionEntity>> pullQcUncheckedData(String code, String userName);
  
  Future<Either<Failure, AdminActionEntity>> clearAllData(String code, String userName);
}