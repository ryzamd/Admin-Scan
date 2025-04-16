import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependencies.dart' as di;
import '../../../auth/login/domain/entities/user_entity.dart';
import '../bloc/admin_action_bloc.dart';
import 'admin_action_page.dart';

class ClearWarehouseQtyPage extends StatelessWidget {
  final UserEntity user;
  
  const ClearWarehouseQtyPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminActionPage(
        user: user,
        title: 'Clear Warehouse Quantity',
        actionType: AdminActionBloc.ACTION_CLEAR_WAREHOUSE_QTY,
        successMessage: 'The warehouse quantity has been successfully cleared.',
      ),
    );
  }
}

class ClearQcInspectionPage extends StatelessWidget {
  final UserEntity user;
  
  const ClearQcInspectionPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminActionPage(
        user: user,
        title: 'Clear QC Inspection Data',
        actionType: AdminActionBloc.ACTION_CLEAR_QC_INSPECTION,
        successMessage: 'The QC inspection data has been successfully cleared.',
      ),
    );
  }
}

class ClearQcDeductionPage extends StatelessWidget {
  final UserEntity user;
  
  const ClearQcDeductionPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminActionPage(
        user: user,
        title: 'Clear QC Deduction',
        actionType: AdminActionBloc.ACTION_CLEAR_QC_DEDUCTION,
        successMessage: 'The QC deduction data has been successfully cleared.',
      ),
    );
  }
}

class PullQcUncheckedDataPage extends StatelessWidget {
  final UserEntity user;
  
  const PullQcUncheckedDataPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminActionPage(
        user: user,
        title: 'Pull QC Unchecked Data',
        actionType: AdminActionBloc.ACTION_PULL_QC_UNCHECKED,
        successMessage: 'The QC unchecked data has been successfully pulled.',
      ),
    );
  }
}

class ClearAllDataPage extends StatelessWidget {
  final UserEntity user;
  
  const ClearAllDataPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AdminActionBloc>(param1: user),
      child: AdminActionPage(
        user: user,
        title: 'Clear All Data',
        actionType: AdminActionBloc.ACTION_CLEAR_ALL_DATA,
        successMessage: 'All data has been successfully cleared.',
      ),
    );
  }
}