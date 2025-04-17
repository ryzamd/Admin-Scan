import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/di/dependencies.dart' as di;
import '../../../../../core/services/navigation_service.dart';
import '../../../../../core/widgets/scafford_custom.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../bloc/logout_bloc.dart';
import '../widgets/logout_button.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().enterProfilePage();
    });
    
    return BlocProvider(
      create: (context) => di.sl<LogoutBloc>(),
      child: CustomScaffold(
        title: 'PROFILE',
        showNavBar: true,
        currentIndex: 2,
        showHomeIcon: false,
        user: user,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF071952),
                Color(0xFF088395),
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xFFFF8008),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFFECE9E6)),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48),
                            child: Image.asset('assets/avatar/Hedgehog.png'),
                          )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    user.userId,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user.role == UserRole.warehouseAdmin ? '管理員' : 'UNKNOW',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),

                  Container(
                    width: 220,
                    height: 55,
                    margin: const EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFFFB4C2),
                          Color(0xFFDA7297),
                        ],
                      ),
                    ),
                    child: const LogoutButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}