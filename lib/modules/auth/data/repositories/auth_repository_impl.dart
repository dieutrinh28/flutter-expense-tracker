import 'package:expense_tracker/modules/auth/domain/entities/user.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_ds.dart';
import '../datasources/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
  })  : _remote = remote,
        _local = local;

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final userModel = await _remote.login(
      email: email,
      password: password,
    );
    await _local.saveUser(userModel);
    return userModel.toDomain();
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final dto = await _remote.register(
      email: email,
      password: password,
      name: name,
    );
    await _local.saveUser(dto);
    return dto.toDomain();
  }

  @override
  Future<void> logout() async {
    final stored = await _local.getStoredUser();
    if (stored != null) {
      await _remote.revokeToken(stored.token);
    }
    await _local.clearUser();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _remote.resetPassword(email: email);
  }

  @override
  Future<User?> getStoredUser() async {
    final stored = await _local.getStoredUser();
    return stored?.toDomain();
  }
}
