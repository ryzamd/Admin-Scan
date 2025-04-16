import 'package:flutter/material.dart';
import '../constants/app_routes.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();
  
  String? lastAdminRoute;
  String? previousMainRoute;
  
  void setLastAdminRoute(String? route) {
    lastAdminRoute = route;
  }
  
  void clearLastAdminRoute() {
    lastAdminRoute = null;
  }
  
  void enterProfilePage() {
    previousMainRoute = AppRoutes.dashboard;
    clearLastAdminRoute();
  }
  
  String getWorkDestination(BuildContext context) {
    if (ModalRoute.of(context)?.settings.name == AppRoutes.profile) {
      return AppRoutes.dashboard;
    }
    
    return lastAdminRoute ?? AppRoutes.dashboard;
  }
  
  bool shouldShowBackButton(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    
    if (currentRoute == AppRoutes.dashboard ||
        currentRoute == AppRoutes.homeData ||
        currentRoute == AppRoutes.profile) {
      return false;
    }
    
    return true;
  }
  
  void handleBackButton(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    
    if (currentRoute != null && currentRoute.startsWith('/admin/')) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.dashboard,
      );
    } else {
      Navigator.pop(context);
    }
  }
}