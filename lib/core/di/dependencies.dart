import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/login/data/data_sources/login_remote_datasource.dart';
import '../../features/auth/login/data/repositories/user_repository_impl.dart';
import '../../features/auth/login/domain/entities/user_entity.dart';
import '../../features/auth/login/domain/repositories/user_repository.dart';
import '../../features/auth/login/domain/usecases/user_login.dart';
import '../../features/auth/login/domain/usecases/validate_token.dart';
import '../../features/auth/login/presentation/bloc/login_bloc.dart';
import '../../features/auth/logout/data/datasources/logout_datasource.dart';
import '../../features/auth/logout/data/repositories/logout_repository_impl.dart';
import '../../features/auth/logout/domain/repositories/logout_repository.dart';
import '../../features/auth/logout/domain/usecases/logout_usecase.dart';
import '../../features/auth/logout/presentation/bloc/logout_bloc.dart';
import '../../features/home_data/data/datasources/home_data_remote_datasource.dart';
import '../../features/home_data/data/repositories/home_data_repository_impl.dart';
import '../../features/home_data/domain/repositories/home_data_repository.dart';
import '../../features/home_data/domain/usecases/get_home_data.dart';
import '../../features/home_data/presentation/bloc/home_data_bloc.dart';
import '../auth/auth_repository.dart';
import '../network/dio_client.dart';
import '../network/network_infor.dart';
import '../network/token_interceptor.dart';
import '../services/secure_storage_service.dart';

final sl = GetIt.instance;

Future<void> initAsync() async {
  await coreFeatureAsync();
  await loginFeatureAsync();
  await logoutFeatureAsync();
  await homeDataFeatureAsync();
}

Future<void> coreFeatureAsync() async {
  sl.registerLazySingleton(() => SecureStorageService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  
  final dioClient = DioClient();
  sl.registerLazySingleton<DioClient>(() => dioClient);
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl<SecureStorageService>(), sl<DioClient>()));
  
  final navigatorKey = GlobalKey<NavigatorState>();
  sl.registerLazySingleton<GlobalKey<NavigatorState>>(() => navigatorKey);
  
  final tokenInterceptor = TokenInterceptor(authRepository: sl<AuthRepository>(), navigatorKey: sl<GlobalKey<NavigatorState>>(),);
  dioClient.dio.interceptors.insert(0, tokenInterceptor);
  sl.registerLazySingleton<Dio>(() => dioClient.dio);
}

Future<void> loginFeatureAsync() async {
  sl.registerFactory(() => LoginBloc(userLogin: sl(),validateToken: sl()));
  sl.registerLazySingleton(() => UserLogin(sl()));
  sl.registerLazySingleton(() => ValidateToken(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(dio: sl<Dio>()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}

Future<void> logoutFeatureAsync() async {
  sl.registerLazySingleton<LogoutDataSource>(() => LogoutDataSourceImpl(sharedPreferences: sl(),dioClient: sl()));
  sl.registerLazySingleton<LogoutRepository>(() => LogoutRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerFactory(() => LogoutBloc(logoutUseCase: sl()));
}

Future<void> homeDataFeatureAsync() async {
  sl.registerFactoryParam<HomeDataBloc, UserEntity, void>(
    (user, _) => HomeDataBloc(
      user: user,
      getHomeData: sl(),
      date: sl(),
    ),
  );

  sl.registerLazySingleton<HomeDataRepository>(
    () => HomeDataRepositoryImpl(
      homeDataRemoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<HomeDataRemoteDataSource>(() => HomeDataRemoteDataSourceImpl(dio: sl()),);
  sl.registerLazySingleton(() => GetHomeData(homeDataRepository: sl()));
}