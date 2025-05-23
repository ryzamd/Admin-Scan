import 'package:admin_scan/features/auth/logout/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_routes.dart';
import 'core/di/dependencies.dart' as di;
import 'core/localization/language_bloc.dart';
import 'core/services/exit_confirmation_service.dart';
import 'core/widgets/splash_screen.dart';
import 'features/admin/presentation/pages/admin_action_use_page.dart';
import 'features/admin/presentation/pages/admin_menu_page.dart';
import 'features/auth/login/domain/entities/user_entity.dart';
import 'features/auth/login/presentation/pages/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await di.initAsync();
  
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BackButtonService _backButtonService = BackButtonService();

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _backButtonService.initialize(navigatorKey.currentContext!);
    });
  }

  @override
  void dispose() {
    _backButtonService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>.value(
      value: di.sl<LanguageBloc>(),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Pro Well',
            debugShowCheckedModeBanner: false,
            locale: languageState.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('zh', ''),
              Locale('zh', 'CN'),
              Locale('zh', 'TW'),
              Locale('vi', ''),
            ],
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
                foregroundColor: AppColors.scaffoldBackground,
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
                
                case AppRoutes.dashboard:
                final args = settings.arguments as UserEntity;

                  return MaterialPageRoute(
                    builder: (_) => AdminMenuPage(user: args,),
                  );

                case AppRoutes.profile:
                final args = settings.arguments as UserEntity;

                  return MaterialPageRoute(
                    builder: (_) => ProfilePage(user: args,),
                  );
                
                case AppRoutes.clearWarehouseQty:
                  final args = settings.arguments as UserEntity;
                  return MaterialPageRoute(
                    builder: (context) => ClearWarehouseQtyPage(user: args),
                  );
                  
                case AppRoutes.clearQcInspection:
                  final args = settings.arguments as UserEntity;
                  return MaterialPageRoute(
                    builder: (context) => ClearQcInspectionPage(user: args),
                  );
                  
                case AppRoutes.clearQcDeduction:
                  final args = settings.arguments as UserEntity;
                  return MaterialPageRoute(
                    builder: (context) => ClearQcDeductionPage(user: args),
                  );
                  
                case AppRoutes.pullQcUnchecked:
                  final args = settings.arguments as UserEntity;
                  return MaterialPageRoute(
                    builder: (context) => PullQcUncheckedDataPage(user: args),
                  );
                  
                case AppRoutes.clearAllData:
                  final args = settings.arguments as UserEntity;
                  return MaterialPageRoute(
                    builder: (context) => ClearAllDataPage(user: args),
                  );
                  
                default:
                  return MaterialPageRoute(
                    builder: (_) => const SplashScreen(),
                  );
              }
            }
          );
        },
      ),
    );
  }
}
