import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/core/errors/app_error.dart';
import 'package:expense_tracker/modules/auth/data/models/user_model.dart';
import 'package:expense_tracker/modules/auth/domain/usecases/login.dart';
import 'package:expense_tracker/modules/auth/domain/usecases/logout.dart';
import 'package:expense_tracker/modules/auth/domain/usecases/check_auth.dart';
import 'package:expense_tracker/modules/auth/data/repositories/auth_repository_impl.dart';
import 'helpers/mock_auth_data.dart';
import 'helpers/fake_auth_ds.dart';

void main() {
  group('Authentication Mock Data Tests', () {
    late FakeAuthTestHelper authHelper;
    late AuthRepositoryImpl authRepository;
    late LoginUseCase loginUseCase;
    late LogoutUseCase logoutUseCase;
    late CheckAuthUseCase checkAuthUseCase;

    setUp(() {
      // Initialize fake data sources
      authHelper = FakeAuthTestHelper();

      // Create repository with fake data sources
      authRepository = AuthRepositoryImpl(
        remote: authHelper.remoteDataSource,
        local: authHelper.localDataSource,
      );

      // Create use cases
      loginUseCase = LoginUseCase(authRepository);
      logoutUseCase = LogoutUseCase(authRepository);
      checkAuthUseCase = CheckAuthUseCase(authRepository);

      // Reset state before each test
      authHelper.reset();
    });

    test('MockAuthData contains valid test credentials', () {
      expect(MockAuthData.validEmail, equals('test@example.com'));
      expect(MockAuthData.validPassword, equals('Password123!'));
      expect(MockAuthData.validUser.id, equals('user_123'));
      expect(MockAuthData.validUser.name, equals('John Doe'));
      expect(MockAuthData.validUser.token.isNotEmpty, true);
    });

    test('MockAuthData.validUser contains all required fields', () {
      final user = MockAuthData.validUser;
      expect(user.id, isNotEmpty);
      expect(user.email, isNotEmpty);
      expect(user.name, isNotEmpty);
      expect(user.token, isNotEmpty);
    });

    test('Mock credentials map has email and password', () {
      final creds = MockAuthData.validCredentials;
      expect(creds, containsPair('email', MockAuthData.validEmail));
      expect(creds, containsPair('password', MockAuthData.validPassword));
    });

    test('FakeAuthRemoteDataSource successful login', () async {
      final user = await authHelper.remoteDataSource.login(
        email: MockAuthData.validEmail,
        password: MockAuthData.validPassword,
      );

      expect(user.email, equals(MockAuthData.validEmail));
      expect(user.id, equals(MockAuthData.validUserId));
      expect(user.name, equals(MockAuthData.validUserName));
    });

    test('FakeAuthRemoteDataSource rejects invalid credentials', () async {
      expect(
        () => authHelper.remoteDataSource.login(
          email: MockAuthData.validEmail,
          password: MockAuthData.invalidPassword,
        ),
        throwsA(isA<ApiBusinessError>()),
      );
    });

    test('FakeAuthRemoteDataSource detects locked accounts', () async {
      expect(
        () => authHelper.remoteDataSource.login(
          email: MockAuthData.lockedEmail,
          password: 'anyPassword',
        ),
        throwsA(isA<ApiBusinessError>()),
      );
    });

    test('FakeAuthLocalDataSource saves and retrieves user', () async {
      final userModel = UserModel.fromEntity(MockAuthData.validUser);

      await authHelper.localDataSource.saveUser(userModel);
      final retrieved = await authHelper.localDataSource.getStoredUser();

      expect(retrieved, isNotNull);
      expect(retrieved?.email, equals(MockAuthData.validEmail));
      expect(retrieved?.id, equals(MockAuthData.validUserId));
    });

    test('FakeAuthLocalDataSource clears user correctly', () async {
      final userModel = UserModel.fromEntity(MockAuthData.validUser);

      await authHelper.localDataSource.saveUser(userModel);
      await authHelper.localDataSource.clearUser();
      final retrieved = await authHelper.localDataSource.getStoredUser();

      expect(retrieved, isNull);
    });

    test('LoginUseCase with valid credentials succeeds', () async {
      final user = await loginUseCase(
        email: MockAuthData.validEmail,
        password: MockAuthData.validPassword,
      );

      expect(user.email, equals(MockAuthData.validEmail));
      expect(user.name, equals(MockAuthData.validUserName));
      expect(user.token.isNotEmpty, true);
    });

    test('CheckAuthUseCase returns user after login', () async {
      // Simulate login
      await authHelper.simulateSuccessfulLogin();

      // Check auth should return the user
      final user = await checkAuthUseCase();
      expect(user, isNotNull);
      expect(user?.email, equals(MockAuthData.validEmail));
    });

    test('CheckAuthUseCase returns null when not logged in', () async {
      final user = await checkAuthUseCase();
      expect(user, isNull);
    });

    test('LogoutUseCase clears user data', () async {
      // Simulate login first
      await authHelper.simulateSuccessfulLogin();

      // Verify user is logged in
      var user = await checkAuthUseCase();
      expect(user, isNotNull);

      // Logout
      await logoutUseCase();

      // Verify user is cleared
      user = await checkAuthUseCase();
      expect(user, isNull);
    });

    test('Alternative test user has correct credentials', () {
      final altUser = MockAuthData.alternativeUser;
      expect(altUser.email, equals('jane@example.com'));
      expect(altUser.name, equals('Jane Smith'));
      expect(altUser.id, equals('user_456'));
    });

    test('User without avatar has null avatar field', () {
      final user = MockAuthData.userNoAvatar;
      expect(user.avatar, isNull);
      expect(user.email, isNotEmpty);
    });

    test('Mock error responses have correct structure', () {
      final invalidCredsError = MockAuthData.mockInvalidCredentialsError;
      expect(invalidCredsError['success'], false);
      expect(invalidCredsError['error'], isNotNull);
      expect(invalidCredsError['error']['code'], 'INVALID_CREDENTIALS');

      final lockedError = MockAuthData.mockAccountLockedError;
      expect(lockedError['success'], false);
      expect(lockedError['error']['code'], 'ACCOUNT_LOCKED');
    });
  });
}
