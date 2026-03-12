part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthChecking extends AuthState {
  const AuthChecking();
}

class AuthLoggingIn extends AuthState {
  const AuthLoggingIn();
}

class AuthLoggingOut extends AuthState {
  final User user;
  const AuthLoggingOut(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthRegistering extends AuthState {
  const AuthRegistering();
}

class AuthResettingPassword extends AuthState {
  const AuthResettingPassword();
}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
