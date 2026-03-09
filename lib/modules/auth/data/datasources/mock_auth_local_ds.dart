import 'package:expense_tracker/modules/auth/data/models/user_model.dart';

import 'auth_local_ds.dart';

class MockAuthLocalDataSource implements AuthLocalDataSource {
  UserModel? _storedUser;

  @override
  Future<void> saveUser(UserModel user) async {
    _storedUser = user;
  }

  @override
  Future<UserModel?> getStoredUser() async {
    return _storedUser;
  }

  @override
  Future<void> clearUser() async {
    _storedUser = null;
  }
}
