import '../../../../core/di/dependencies.dart' as di;
import '../../../auth/login/domain/entities/user_entity.dart';
import '../../config/home_data_config.dart';
import '../../domain/usecases/get_home_data.dart';
import 'home_data_bloc.dart';

class HomeDataBlocFactory {
  HomeDataBlocFactory._();
  
  static HomeDataBloc createBloc(UserEntity user, String functionType) {
    return HomeDataBloc(
      getHomeData: di.sl<GetHomeData>(),
      user: user,
    );
  }

  static HomeDataBloc createClearWarehouseQtyBloc(UserEntity user) {
    return createBloc(user, 'clear_warehouse_qty');
  }
  
  static HomeDataBloc createClearQcInspectionBloc(UserEntity user) {
    return createBloc(user, 'clear_qc_inspection');
  }
  
  static HomeDataBloc createClearQcDeductionBloc(UserEntity user) {
    return createBloc(user, 'clear_qc_deduction');
  }
  
  static HomeDataBloc createPullQcUncheckedBloc(UserEntity user) {
    return createBloc(user, 'pull_qc_unchecked');
  }
  
  static HomeDataBloc createClearAllDataBloc(UserEntity user) {
    return createBloc(user, 'clear_all_data');
  }
  
  static HomeDataConfig getConfigForFunction(String functionType) {
    switch (functionType) {
      case 'clear_warehouse_qty':
        return HomeDataConfig.clearWarehouseQtyConfig();
      case 'clear_qc_inspection':
        return HomeDataConfig.clearQcInspectionConfig();
      case 'clear_qc_deduction':
        return HomeDataConfig.clearQcDeductionConfig();
      case 'pull_qc_unchecked':
        return HomeDataConfig.pullQcUncheckedConfig();
      case 'clear_all_data':
        return HomeDataConfig.clearAllDataConfig();
      default:
        return HomeDataConfig.defaultConfig();
    }
  }
}