import 'package:expense_tracker/modules/auth/domain/entities/user.dart';

/// Mock users for testing authentication flows
class MockAuthData {
  // Valid test users
  static const String validEmail = 'test@example.com';
  static const String validPassword = 'Password123!';
  static const String validUserId = 'user_123';
  static const String validUserName = 'John Doe';
  static const String validToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyXzEyMyIsImVtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTUxNjIzOTAyMn0.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
  static const String validAvatar = 'https://example.com/avatars/john.jpg';

  // Invalid credentials
  static const String invalidEmail = 'wrong@example.com';
  static const String invalidPassword = 'WrongPassword123!';
  static const String lockedEmail = 'locked@example.com';

  /// Main test user
  static const User validUser = User(
    id: validUserId,
    email: validEmail,
    name: validUserName,
    avatar: validAvatar,
    token: validToken,
  );

  /// Alternative test user
  static const User alternativeUser = User(
    id: 'user_456',
    email: 'jane@example.com',
    name: 'Jane Smith',
    avatar: null,
    token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyXzQ1NiIsImVtYWlsIjoiamFuZUBleGFtcGxlLmNvbSJ9.mock_token_456',
  );

  /// User without avatar
  static const User userNoAvatar = User(
    id: 'user_789',
    email: 'no.avatar@example.com',
    name: 'No Avatar User',
    token: 'mock_token_789',
  );

  /// Test credentials that should succeed
  static Map<String, String> get validCredentials => {
        'email': validEmail,
        'password': validPassword,
      };

  /// Test credentials that should fail (wrong password)
  static Map<String, String> get invalidCredentials => {
        'email': validEmail,
        'password': invalidPassword,
      };

  /// Test credentials for non-existent user
  static Map<String, String> get nonExistentUserCredentials => {
        'email': invalidEmail,
        'password': validPassword,
      };

  /// Test credentials for locked account
  static Map<String, String> get lockedAccountCredentials => {
        'email': lockedEmail,
        'password': 'anyPassword123!',
      };

  /// Mock login response (JSON from API)
  static Map<String, dynamic> get mockLoginResponse => {
        'success': true,
        'data': {
          'id': validUserId,
          'email': validEmail,
          'name': validUserName,
          'avatar': validAvatar,
          'token': validToken,
        }
      };

  /// Mock check auth response (user still authenticated)
  static Map<String, dynamic> get mockCheckAuthResponse => {
        'success': true,
        'data': {
          'id': validUserId,
          'email': validEmail,
          'name': validUserName,
          'avatar': validAvatar,
          'token': validToken,
        }
      };

  /// Mock error response (invalid credentials)
  static Map<String, dynamic> get mockInvalidCredentialsError => {
        'success': false,
        'error': {
          'code': 'INVALID_CREDENTIALS',
          'message': 'Invalid email or password',
        }
      };

  /// Mock error response (account locked)
  static Map<String, dynamic> get mockAccountLockedError => {
        'success': false,
        'error': {
          'code': 'ACCOUNT_LOCKED',
          'message': 'Account locked. Please contact support.',
        }
      };

  /// Mock error response (server error)
  static Map<String, dynamic> get mockServerError => {
        'success': false,
        'error': {
          'code': 'SERVER_ERROR',
          'message': 'Internal server error. Please try again later.',
        }
      };

  /// Mock logout response
  static Map<String, dynamic> get mockLogoutResponse => {
        'success': true,
        'message': 'Logged out successfully',
      };
}
