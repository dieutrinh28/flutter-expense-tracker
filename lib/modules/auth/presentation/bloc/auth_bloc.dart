import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/errors/api_error_codes.dart';
import 'package:expense_tracker/core/errors/app_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/bloc_safe_runner.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/check_auth.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/reset_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_effect.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  final BlocSafeRunner runner;

  final _effectController = StreamController<AuthEffect>.broadcast();
  Stream<AuthEffect> get effects => _effectController.stream;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.resetPasswordUseCase,
    required this.logoutUseCase,
    required this.checkAuthUseCase,
    required this.runner,
  }) : super(const AuthInitial()) {
    on<CheckAuthEvent>(_onCheckAuth);
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ResetPasswordEvent>(_onResetPassword);
    on<LogoutEvent>(_onAuthLogout);
  }

  Future<void> _onCheckAuth(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: const AuthChecking(),
      action: () async {
        final user = await checkAuthUseCase();
        if (user != null) {
          emit(AuthAuthenticated(user));
          _effectController.add(NavigateToHomeEffect());
        } else {
          emit(const AuthUnauthenticated());
          _effectController.add(NavigateToLoginEffect());
        }
      },
      onError: (error) {
        return AuthError(error.message);
      },
      errorEffect: (_) => NavigateToLoginEffect(),
      logContext: {'event': 'CheckAuth'},
    );
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: const AuthLoggingIn(),
      action: () async {
        final user = await loginUseCase(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(user));
        _effectController.add(NavigateToHomeEffect());
      },
      onError: (error) {
        return AuthError(error.message);
      },
      errorEffect: (error) {
        if (error is ValidationError) {
          return ShowValidationErrorEffect(error.fieldErrors);
        }
        if (error is ApiBusinessError) {
          return switch (error.errorCode) {
            ApiErrorCode.invalidCredentials =>
              ShowErrorEffect('Wrong email or password.'),
            ApiErrorCode.accountLocked =>
              ShowErrorEffect('Account locked. Please contact support.'),
            _ => ShowErrorEffect(error.message),
          };
        }
        return ShowErrorEffect(error.message);
      },
      logContext: {'event': 'Login', 'email': event.email},
    );
  }

  Future<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: const AuthRegistering(),
      action: () async {
        final user = await registerUseCase(
          email: event.email,
          password: event.password,
          name: event.name,
        );
        emit(AuthAuthenticated(user));
        _effectController.add(NavigateToHomeEffect());
      },
      onError: (error) => AuthError(error.message),
      errorEffect: (error) {
        if (error is ValidationError) {
          return ShowValidationErrorEffect(error.fieldErrors);
        }
        if (error is ApiBusinessError &&
            error.errorCode == ApiErrorCode.emailAlreadyExists) {
          return ShowErrorEffect('Email is already in use.');
        }
        return ShowErrorEffect(error.message);
      },
      logContext: {'event': 'Register', 'email': event.email},
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: const AuthResettingPassword(),
      action: () async {
        await resetPasswordUseCase(email: event.email);
        _effectController.add(ResetPasswordSentEffect());
      },
      onError: (error) => AuthError(error.message),
      errorEffect: (error) {
        if (error is ValidationError) {
          return ShowValidationErrorEffect(error.fieldErrors);
        }
        return ShowErrorEffect(error.message);
      },
      logContext: {'event': 'ResetPassword', 'email': event.email},
    );
  }

  Future<void> _onAuthLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final currentUser = switch (state) {
      AuthAuthenticated(:final user) => user,
      _ => null,
    };
    if (currentUser == null) return;

    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: AuthLoggingOut(currentUser),
      action: () async {
        await logoutUseCase();
        emit(const AuthUnauthenticated());
        _effectController.add(ShowLogoutSuccessEffect());
        _effectController.add(NavigateToLoginEffect());
      },
      onError: (error) {
        return AuthError(error.message);
      },
      errorEffect: (_) => NavigateToLoginEffect(),
      logContext: {'event': 'Logout'},
    );
  }

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }
}
