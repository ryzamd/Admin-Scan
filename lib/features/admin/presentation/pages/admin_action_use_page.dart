import 'package:admin_scan/core/services/get_translate_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/di/dependencies.dart' as di;
import '../../../../core/services/navigation_service.dart';
import '../../../auth/login/domain/entities/user_entity.dart';
import '../bloc/admin_action_bloc.dart';
import 'admin_function_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: AppLocalizations.of(context).clearWarehouseQuantityLabel,
        actionType: FunctionType.ACTION_CLEAR_WAREHOUSE_QTY,
        successMessage: AppLocalizations.of(context).clearWarehouseQuantitySuccessMessage,
        functionType: FunctionType.ACTION_CLEAR_WAREHOUSE_QTY,
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
        title: AppLocalizations.of(context).clearQcInspectionLabel,
        actionType: FunctionType.ACTION_CLEAR_QC_INSPECTION,
        successMessage: AppLocalizations.of(context).clearQcInspectionMessage,
        functionType: FunctionType.ACTION_CLEAR_QC_INSPECTION,
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
        title: AppLocalizations.of(context).clearQcDeductionLabel,
        actionType: FunctionType.ACTION_CLEAR_QC_DEDUCTION,
        successMessage: AppLocalizations.of(context).clearQcDeductionMessage,
        functionType: FunctionType.ACTION_CLEAR_QC_DEDUCTION,
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
        title: AppLocalizations.of(context).importUncheckedLabel,
        actionType: FunctionType.ACTION_PULL_QC_UNCHECKED,
        successMessage: AppLocalizations.of(context).importUncheckedMessage,
        functionType: FunctionType.ACTION_PULL_QC_UNCHECKED,
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
        title: AppLocalizations.of(context).clearAllDataLabel,
        actionType: FunctionType.ACTION_CLEAR_ALL_DATA,
        successMessage: AppLocalizations.of(context).clearAllDataMessage,
        functionType: FunctionType.ACTION_CLEAR_ALL_DATA,
      ),
    );
  }
}