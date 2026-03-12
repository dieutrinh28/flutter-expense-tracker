import 'package:expense_tracker/modules/auth/data/models/user_dto.dart';

import '../../../../core/errors/app_error.dart';
import 'auth_remote_ds.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  static const _mockAccounts = [
    {
      'id': 'mock_user_1',
      'email': 'test@test.com',
      'password': '123456',
      'name': 'Test User',
      'token': 'mock_token_abc123',
    },
  ];

  @override
  Future<UserDto> login({
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

    return UserDto.fromJson(account);
  }

  @override
  Future<UserDto> register({
    required String email,
    required String password,
    required String name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final exists = _mockAccounts.any((a) => a['email'] == email);
    if (exists) {
      throw ApiBusinessError(
        errorCode: 'EMAIL_TAKEN',
        message: 'Email is already in use',
        details: null,
      );
    }

    return UserDto(
      id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      name: name,
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> revokeToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
