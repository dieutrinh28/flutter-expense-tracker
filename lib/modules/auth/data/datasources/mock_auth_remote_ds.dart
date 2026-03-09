import 'package:expense_tracker/modules/auth/data/models/user_model.dart';

import '../../../../core/errors/app_error.dart';
import 'auth_remote_ds.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  static const _mockAccounts = [
    {
      'email': 'test@test.com',
      'password': '123456',
      'id': 'mock_user_1',
      'name': 'Test User',
      'token': 'mock_token_abc123',
    },
  ];

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final account = _mockAccounts.firstWhere(
      (a) => a['email'] == email && a['password'] == password,
      orElse: () => {},
    );

    if (account.isEmpty) {
      throw ApiBusinessError(
        errorCode: 'INVALID_CREDENTIALS',
        message: 'Email or password is incorrect',
        details: null,
      );
    }

    return UserModel.fromMap(account);
  }

  @override
  Future<void> revokeToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
