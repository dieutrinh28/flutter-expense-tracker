import '../repositories/auth_repository.dart';
import '../value_objects/email.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  const ResetPasswordUseCase(this._repository);

  Future<void> call({required String email}) async {
    final validEmail = Email.create(email);
    return _repository.resetPassword(email: validEmail.value);
  }
}
