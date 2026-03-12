part of 'auth_bloc.dart';

sealed class AuthEffect {}

// Navigation effects
class NavigateToHomeEffect extends AuthEffect {}

class NavigateToLoginEffect extends AuthEffect {}

// UI feedback effects
class ShowLogoutSuccessEffect extends AuthEffect {}

class ShowErrorEffect extends AuthEffect {
  final String message;
  ShowErrorEffect(this.message);
}

class ResetPasswordSentEffect extends AuthEffect {
  ResetPasswordSentEffect();
}

// Validation effect
class ShowValidationErrorEffect extends AuthEffect {
  final Map<String, String> fieldErrors;
  ShowValidationErrorEffect(this.fieldErrors);
}
