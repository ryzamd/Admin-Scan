import 'package:flutter/material.dart';
import '../constants/app_routes.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();
  
  String? lastAdminRoute;
  String? previousMainRoute;
  
  void setLastAdminRoute(String? route) {
    if (route != null && route.startsWith('/admin/')) {
      lastAdminRoute = route;
    }
  }
  
  void clearLastAdminRoute() {
    lastAdminRoute = null;
  }
  
  void enterHomePage() {
    previousMainRoute = AppRoutes.homeData;
  }
  
  void enterProfilePage() {
    previousMainRoute = AppRoutes.dashboard;
    clearLastAdminRoute();
  }
  
  String getWorkDestination(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    
    if (currentRoute == AppRoutes.homeData && lastAdminRoute != null) {
      return lastAdminRoute!;
    }
    
    if (currentRoute == AppRoutes.profile) {
      return AppRoutes.dashboard;
    }
    
    return lastAdminRoute ?? AppRoutes.dashboard;
  }
  
  bool shouldShowBackButton(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    
    if (currentRoute != null && currentRoute.startsWith('/admin/')) {
      return true;
    }
    
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
        arguments: ModalRoute.of(context)?.settings.arguments
      );
    } else {
      Navigator.pop(context);
    }
  }
}