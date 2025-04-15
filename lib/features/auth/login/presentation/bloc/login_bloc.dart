import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/auth/auth_repository.dart';
import '../../../../../core/di/dependencies.dart' as di;
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/validate_token.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLogin userLogin;
  final ValidateToken validateToken;

  LoginBloc({required this.userLogin, required this.validateToken}): super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressedAsync);
    on<ResetLoginStateEvent>(_onResetLoginStateAsync);
    on<CheckToken>(_onCheckTokenAsync);
  }

  Future<void> _onLoginButtonPressedAsync(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final result = await di.sl<AuthRepository>().loginUserAsync(
      userId: event.userId,
      password: event.password,
      name: event.name,
    );

    result.fold(
      (failure) => emit(LoginFailure(message: failure.message)),
      (user) async {
        emit(LoginSuccess(user: user));
        
        await di.sl<AuthRepository>().debugTokenStateAsync();
      }
    );
  }

  Future<void> _onCheckTokenAsync(CheckToken event, Emitter<LoginState> emit) async {
    emit(TokenChecking());

    final result = await validateToken(TokenParams(token: event.token));

    result.fold(
      (failure) => emit(LoginInitial()),
      (user) => emit(LoginSuccess(user: user)),
    );
  }

  void _onResetLoginStateAsync(ResetLoginStateEvent event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }
}