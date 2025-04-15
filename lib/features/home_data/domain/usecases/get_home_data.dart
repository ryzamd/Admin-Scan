import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/home_data_entity.dart';
import '../repositories/home_data_repository.dart';

class GetHomeData {
  final HomeDataRepository homeDataRepository;

  GetHomeData({required this.homeDataRepository});

  Future<Either<Failure, List<HomeDataEntity>>> call(HomeDataParams params) async {
    return await homeDataRepository.getHomeDataAsync(params.date);
  }
}

class HomeDataParams extends Equatable {
  final String date;

  const HomeDataParams({required this.date});
  
  @override
  List<Object> get props => [date];
}