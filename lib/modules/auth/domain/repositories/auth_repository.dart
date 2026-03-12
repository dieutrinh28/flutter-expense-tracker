import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String email,
    required String password,
    required String name,
  });

  Future<void> logout();

  Future<void> resetPassword({required String email});

  Future<User?> getStoredUser();
}
