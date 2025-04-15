import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/home_data_entity.dart';

abstract class HomeDataRepository {
  Future<Either<Failure, List<HomeDataEntity>>> getHomeDataAsync(String date);
}