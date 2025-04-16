import 'package:flutter/material.dart';
import '../../features/auth/login/domain/entities/user_entity.dart';
import '../constants/app_colors.dart';
import '../services/navigation_service.dart';
import 'navbar_custom.dart';


class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final bool showNavBar;
  final int currentIndex;
  final bool showBackButton;
  final Color? backgroundColor;
  final PreferredSizeWidget? customAppBar;
  final UserEntity? user;
  final bool showHomeIcon;

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.showNavBar = true,
    this.currentIndex = 0,
    this.showBackButton = false,
    this.backgroundColor,
    this.customAppBar,
    this.user,
    this.showHomeIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor ?? AppColors.scaffoldBackground,
      appBar: customAppBar ?? _buildAppBar(context),
      body: SafeArea(
        child: body,
      ),
      bottomNavigationBar: showNavBar ? CustomNavBar(currentIndex: currentIndex, user: user, showHomeIcon: showHomeIcon,) : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final navigationService = NavigationService();
    final shouldShowBack = showBackButton || navigationService.shouldShowBackButton(context);

    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF4158A6)
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: shouldShowBack && showHomeIcon
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => navigationService.handleBackButton(context),
              )
            : null,
      actions: actions,
    );
  }
}