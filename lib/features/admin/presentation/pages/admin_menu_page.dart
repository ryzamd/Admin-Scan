import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/di/dependencies.dart' as di;
import '../../../../core/services/navigation_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/widgets/scafford_custom.dart';
import '../../../auth/login/domain/entities/user_entity.dart';

class AdminMenuPage extends StatefulWidget {
  final UserEntity user;
  
  const AdminMenuPage({super.key, required this.user});

  @override
  State<AdminMenuPage> createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {

  String _department = 'Quality Control';
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadDepartment();
  }
  
  Future<void> _loadDepartment() async {
    final department = await di.sl<SecureStorageService>().getUserDepartmentAsync();
    if (mounted) {
      setState(() {
        _department = department ?? 'Quality Control';
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().clearLastAdminRoute();
    });
    
    if (_isLoading) {
      return const CustomScaffold(
        title: 'Admin Menu',
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return CustomScaffold(
      title: 'Admin Menu',
      user: widget.user,
      showHomeIcon: false,
      currentIndex: 1,
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF283048),
                Color(0xFF859398),
              ],
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: _buildFunctionsByDepartment(),
          ),
        ),
      )
    );
  }

  Widget _buildAdminActionTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
    bool isDestructive = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Color(0xFFEAEAEA),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive ? AppColors.redCommon.withValues(alpha: 0.1) : AppColors.blueCommon.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isDestructive ? AppColors.redCommon : AppColors.blueCommon,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDestructive ? AppColors.redCommon.withValues(alpha: 0.8) : AppColors.blackCommon,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(
            context,
            route,
            arguments: widget.user,
          );
        },
      ),
    );
  }

  List<Widget> _buildFunctionsByDepartment() {
    if (_department  == 'Quality Control') {
      return [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Text('Quality Control',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: AppColors.scaffoldBackground),
            ),
          ),
        ),

        _buildAdminActionTile(
          context,
          title: '清除質檢與扣碼資料',
          icon: Icons.cleaning_services,
          route: AppRoutes.clearQcInspection,
        ),
        _buildAdminActionTile(
          context,
          title: '清除扣碼資料',
          icon: Icons.remove_circle,
          route: AppRoutes.clearQcDeduction,
        ),
      ];
    }
    else if (_department  == 'Warehouse Manager') {
      return [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Text('Quality Control',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: AppColors.scaffoldBackground),
            ),
          ),
        ),

        _buildAdminActionTile(
          context,
          title: '清除入庫資料',
          icon: Icons.delete_sweep,
          route: AppRoutes.clearWarehouseQty,
        ),
        _buildAdminActionTile(
          context,
          title: '導入未質檢資料',
          icon: Icons.download,
          route: AppRoutes.pullQcUnchecked,
        ),
        // _buildAdminActionTile(
        //   context,
        //   title: '清除全部資料（不含已出庫)',
        //   icon: Icons.delete_forever,
        //   route: AppRoutes.clearAllData,
        //   isDestructive: true,
        // ),
      ];
    }
    return [];
  }
}