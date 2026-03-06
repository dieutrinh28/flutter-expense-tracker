import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getStoredUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userKey = 'stored_user';
  final SharedPreferences _prefs;

  AuthLocalDataSourceImpl(this._prefs);

  @override
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_userKey, jsonEncode(user.toMap()));
  }

  @override
  Future<UserModel?> getStoredUser() async {
    final json = _prefs.getString(_userKey);
    if (json == null) return null;
    return UserModel.fromMap(jsonDecode(json) as Map<String, dynamic>);
  }

  @override
  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
  }
}