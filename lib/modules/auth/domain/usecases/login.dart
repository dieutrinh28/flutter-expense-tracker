import 'package:expense_tracker/modules/auth/domain/entities/user.dart';
import 'package:expense_tracker/modules/auth/domain/repositories/auth_repository.dart';

import '../value_objects/email.dart';
import '../value_objects/password.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<User> call({
    required String email,
    required String password,
  }) async {
    final validEmail = Email.create(email);
    final validPassword = Password.create(password);

    return _repository.login(
      email: validEmail.value,
      password: validPassword.value,
    );
  }
}
