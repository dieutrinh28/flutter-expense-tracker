import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class CheckAuthUseCase {
  final AuthRepository _repository;
  const CheckAuthUseCase(this._repository);

  Future<User?> call() => _repository.getStoredUser();
}
