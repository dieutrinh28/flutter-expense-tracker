import 'package:expense_tracker/core/network/dio_client.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/network/api_response.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<void> revokeToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;
  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<UserModel> login({
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
    final parsed = ApiResponseParser.parse<UserModel>(
      response.data,
      (data) => UserModel.fromMap(data),
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
  Future<void> revokeToken(String token) async {
    await _client.post(
      '/auth/logout',
      data: {'token': token},
    );
  }
}
