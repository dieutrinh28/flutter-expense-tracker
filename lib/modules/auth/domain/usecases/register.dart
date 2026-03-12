import 'package:expense_tracker/modules/auth/domain/entities/user.dart';
import 'package:expense_tracker/modules/auth/domain/repositories/auth_repository.dart';

import '../value_objects/email.dart';
import '../value_objects/password.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  const RegisterUseCase(this._repository);

  Future<User> call({
    required String email,
    required String password,
    required String name,
  }) async {
    final validEmail = Email.create(email);
    final validPassword = Password.create(password);

    if (name.trim().isEmpty) {
      throw ArgumentError('Name is required');
    }

    return _repository.register(
      email: validEmail.value,
      password: validPassword.value,
      name: name.trim(),
    );
  }
}
