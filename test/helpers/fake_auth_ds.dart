import 'dart:convert';
import 'package:expense_tracker/modules/auth/data/datasources/auth_local_ds.dart';
import 'package:expense_tracker/modules/auth/data/datasources/auth_remote_ds.dart';
import 'package:expense_tracker/modules/auth/data/models/user_model.dart';
import 'package:expense_tracker/core/errors/app_error.dart';
import 'package:expense_tracker/core/errors/api_error_codes.dart';
import 'mock_auth_data.dart';

/// Fake remote data source for testing authentication
class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  UserModel? _currentUser;
  bool _isAccountLocked = false;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Check for locked account
    if (email == MockAuthData.lockedEmail) {
      _isAccountLocked = true;
      throw ApiBusinessError(
        errorCode: ApiErrorCode.accountLocked,
        message: 'Account locked. Please contact support.',
      );
    }

    // Check for valid credentials
    if (email == MockAuthData.validEmail &&
        password == MockAuthData.validPassword) {
      _currentUser = UserModel(
        id: MockAuthData.validUser.id,
        email: MockAuthData.validUser.email,
        name: MockAuthData.validUser.name,
        avatar: MockAuthData.validUser.avatar,
        token: MockAuthData.validUser.token,
      );
      return _currentUser!;
    }

    // Invalid credentials
    throw ApiBusinessError(
      errorCode: ApiErrorCode.invalidCredentials,
      message: 'Invalid email or password',
    );
  }

  @override
  Future<void> revokeToken(String token) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  /// Get the currently logged-in user (for testing purposes)
  UserModel? get currentUser => _currentUser;

  /// Reset the fake data source
  void reset() {
    _currentUser = null;
    _isAccountLocked = false;
  }

  /// Set a specific user as logged in (for testing purposes)
  void setCurrentUser(UserModel user) {
    _currentUser = user;
  }
}

/// Fake local data source for testing auth persistence
class FakeAuthLocalDataSource implements AuthLocalDataSource {
  final Map<String, String> _storage = {};

  @override
  Future<void> saveUser(UserModel user) async {
    _storage['stored_user'] = jsonEncode(user.toMap());
  }

  @override
  Future<UserModel?> getStoredUser() async {
    final json = _storage['stored_user'];
    if (json == null) return null;
    try {
      return UserModel.fromMap(jsonDecode(json) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    _storage.remove('stored_user');
  }

  /// Get all stored data (for testing/debugging)
  Map<String, String> getStorage() => Map.from(_storage);

  /// Reset the fake data source
  void reset() {
    _storage.clear();
  }
}

/// Fake auth repository helper class for unit tests
class FakeAuthTestHelper {
  final FakeAuthRemoteDataSource remoteDataSource;
  final FakeAuthLocalDataSource localDataSource;

  FakeAuthTestHelper({
    FakeAuthRemoteDataSource? remote,
    FakeAuthLocalDataSource? local,
  })  : remoteDataSource = remote ?? FakeAuthRemoteDataSource(),
        localDataSource = local ?? FakeAuthLocalDataSource();

  /// Simulate successful login and persistence
  Future<void> simulateSuccessfulLogin() async {
    final user = UserModel(
      id: MockAuthData.validUserId,
      email: MockAuthData.validEmail,
      name: MockAuthData.validUserName,
      avatar: MockAuthData.validAvatar,
      token: MockAuthData.validToken,
    );
    await localDataSource.saveUser(user);
    remoteDataSource.setCurrentUser(user);
  }

  /// Simulate logout
  Future<void> simulateLogout() async {
    await localDataSource.clearUser();
    remoteDataSource.reset();
  }

  /// Reset all fake data sources to initial state
  void reset() {
    remoteDataSource.reset();
    localDataSource.reset();
  }
}
