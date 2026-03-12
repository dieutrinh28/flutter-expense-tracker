import 'package:expense_tracker/modules/auth/data/models/user_dto.dart';

import 'auth_local_ds.dart';

class MockAuthLocalDataSource implements AuthLocalDataSource {
  UserDto? _storedUser;

  @override
  Future<void> saveUser(UserDto dto) async {
    _storedUser = dto;
  }

  @override
  Future<UserDto?> getStoredUser() async {
    return _storedUser;
  }

  @override
  Future<void> clearUser() async {
    _storedUser = null;
  }
}
