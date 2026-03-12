import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_dto.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserDto user);
  Future<UserDto?> getStoredUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;

  const AuthLocalDataSourceImpl(this._prefs);

  static const String _userKey = 'stored_user';

  @override
  Future<void> saveUser(UserDto user) async {
    await _prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<UserDto?> getStoredUser() async {
    final json = _prefs.getString(_userKey);
    if (json == null) return null;
    return UserDto.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  @override
  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
  }
}
