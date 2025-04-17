import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/di/dependencies.dart' as di;
import '../../../../core/services/navigation_service.dart';
import '../../../auth/login/domain/entities/user_entity.dart';
import '../bloc/admin_action_bloc.dart';
import 'admin_function_page.dart';

class ClearWarehouseQtyPage extends StatelessWidget {
  final UserEntity user;
  
  const ClearWarehouseQtyPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().setLastAdminRoute(AppRoutes.clearWarehouseQty);
    });

    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminFunctionPageWithHomeData(
        user: user,
        title: 'Clear WH Quantity',
        actionType: AdminActionBloc.ACTION_CLEAR_WAREHOUSE_QTY,
        successMessage: 'The warehouse quantity has been successfully cleared.',
        functionType: 'clear_warehouse_qty',
      ),
    );
  }
}

class ClearQcInspectionPage extends StatelessWidget {
  final UserEntity user;
  
  const ClearQcInspectionPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().setLastAdminRoute(AppRoutes.clearQcInspection);
    });

    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminFunctionPageWithHomeData(
        user: user,
        title: 'Clear QC Inspected',
        actionType: AdminActionBloc.ACTION_CLEAR_QC_INSPECTION,
        successMessage: 'The QC inspection data has been successfully cleared.',
        functionType: 'clear_qc_inspection',
      ),
    );
  }
}

class ClearQcDeductionPage extends StatelessWidget {
  final UserEntity user;
  
  const ClearQcDeductionPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().setLastAdminRoute(AppRoutes.clearQcDeduction);
    });

    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminFunctionPageWithHomeData(
        user: user,
        title: 'Clear QC Deducted',
        actionType: AdminActionBloc.ACTION_CLEAR_QC_DEDUCTION,
        successMessage: 'The QC deduction data has been successfully cleared.',
        functionType: 'clear_qc_deduction',
      ),
    );
  }
}

class PullQcUncheckedDataPage extends StatelessWidget {
  final UserEntity user;
  
  const PullQcUncheckedDataPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().setLastAdminRoute(AppRoutes.pullQcUnchecked);
    });

    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminFunctionPageWithHomeData(
        user: user,
        title: 'Import Material Unchecked',
        actionType: AdminActionBloc.ACTION_PULL_QC_UNCHECKED,
        successMessage: 'The QC unchecked data has been successfully pulled.',
        functionType: 'pull_qc_unchecked',
      ),
    );
  }
}

class ClearAllDataPage extends StatelessWidget {
  final UserEntity user;
  
  const ClearAllDataPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().setLastAdminRoute(AppRoutes.clearAllData);
    });
    
    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminFunctionPageWithHomeData(
        user: user,
        title: 'Clear All Data',
        actionType: AdminActionBloc.ACTION_CLEAR_ALL_DATA,
        successMessage: 'All data has been successfully cleared.',
        functionType: 'clear_all_data',
      ),
    );
  }
}