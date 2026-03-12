import 'package:expense_tracker/core/network/dio_client.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/network/api_response.dart';
import '../models/user_dto.dart';

abstract class AuthRemoteDataSource {
  Future<UserDto> login({
    required String email,
    required String password,
  });

  Future<UserDto> register({
    required String email,
    required String password,
    required String name,
  });

  Future<void> resetPassword({required String email});

  Future<void> revokeToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<UserDto> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    final parsed = ApiResponseParser.parse<UserDto>(
      response.data,
      (data) => UserDto.fromJson(data),
    );

    return switch (parsed) {
      ApiSuccess(:final data) => data,
      ApiFailure(:final errorCode, :final message, :final details) =>
        throw ApiBusinessError(
          errorCode: errorCode,
          message: message,
          details: details,
        ),
    };
  }

  @override
  Future<UserDto> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await _client.post(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
      },
    );

    final parsed = ApiResponseParser.parse<UserDto>(
      response.data,
      (data) => UserDto.fromJson(data),
    );

    return switch (parsed) {
      ApiSuccess(:final data) => data,
      ApiFailure(:final errorCode, :final message, :final details) =>
        throw ApiBusinessError(
          errorCode: errorCode,
          message: message,
          details: details,
        ),
    };
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _client.post(
      '/auth/reset-password',
      data: {'email': email},
    );
  }

  @override
  Future<void> revokeToken(String token) async {
    await _client.post(
      '/auth/logout',
      data: {'token': token},
    );
  }
}
