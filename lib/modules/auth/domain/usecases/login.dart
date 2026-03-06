import 'package:expense_tracker/modules/auth/domain/entities/user.dart';
import 'package:expense_tracker/modules/auth/domain/repositories/auth_repository.dart';

import '../../../../core/errors/app_error.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<User> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || !email.contains('@')) {
      throw ValidationError({'email': 'Invalid email format'});
    }

    if (password.length < 6) {
      throw ValidationError({'password': 'Password too short'});
    }

    return _repository.login(email: email, password: password);
  }
}
