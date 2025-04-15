import 'package:admin_scan/features/home_data/presentation/pages/home_data_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_routes.dart';
import 'core/di/dependencies.dart' as di;
import 'core/services/exit_confirmation_service.dart';
import 'core/widgets/splash_screen.dart';
import 'features/auth/login/domain/entities/user_entity.dart';
import 'features/auth/login/presentation/pages/login_page.dart';
import 'features/home_data/presentation/bloc/home_data_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initAsync();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final BackButtonService _backButtonService = BackButtonService();
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Pro Well',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
          secondary: AppColors.accent,
        ),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings){
        switch (settings.name) {

          case AppRoutes.splash:
            return MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            );

          case AppRoutes.login:
            return MaterialPageRoute(
              builder: (_) => const LoginPage(),
            );
          
          case AppRoutes.homeData:
           final args = settings.arguments as UserEntity;
           
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => di.sl<HomeDataBloc>(param1: args),
                child: HomeDataPage(user: args),
              )
            );

          default:
            return MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            );
        }
      }

    );
  }
}
