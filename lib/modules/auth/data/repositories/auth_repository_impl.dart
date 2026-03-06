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
    return userModel.toEntity();
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
  Future<User?> getStoredUser() async {
    final stored = await _local.getStoredUser();
    return stored?.toEntity();
  }
}
