import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/widgets/scafford_custom.dart';
import '../../../auth/login/domain/entities/user_entity.dart';

class AdminMenuPage extends StatelessWidget {
  final UserEntity user;
  
  const AdminMenuPage({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().clearLastAdminRoute();
    });
    
    return CustomScaffold(
      title: 'Admin Menu',
      user: user,
      showHomeIcon: false,
      currentIndex: 1,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildAdminActionTile(
              context,
              title: 'Clear Warehouse Quantity',
              subtitle: 'Clear warehouse import quantity data',
              icon: Icons.delete_sweep,
              route: AppRoutes.clearWarehouseQty,
            ),
            _buildAdminActionTile(
              context,
              title: 'Clear QC Inspection Data',
              subtitle: 'Clear QC inspection and deduction data',
              icon: Icons.cleaning_services,
              route: AppRoutes.clearQcInspection,
            ),
            _buildAdminActionTile(
              context,
              title: 'Clear QC Deduction',
              subtitle: 'Clear QC deduction code quantity',
              icon: Icons.remove_circle,
              route: AppRoutes.clearQcDeduction,
            ),
            _buildAdminActionTile(
              context,
              title: 'Pull QC Unchecked Data',
              subtitle: 'Pull QC unchecked data',
              icon: Icons.download,
              route: AppRoutes.pullQcUnchecked,
            ),
            _buildAdminActionTile(
              context,
              title: 'Clear All Data',
              subtitle: 'Clear all data (excluding outbound data)',
              icon: Icons.delete_forever,
              route: AppRoutes.clearAllData,
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAdminActionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required String route,
    bool isDestructive = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive ? Colors.red.withValues(alpha: 0.1) : Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isDestructive ? Colors.red : Colors.blue,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDestructive ? Colors.red.shade800 : Colors.black87,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(
            context,
            route,
            arguments: user,
          );
        },
      ),
    );
  }
}