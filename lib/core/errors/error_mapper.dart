import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import 'app_error.dart';
import 'error_messages.dart';

class ErrorMapper {
  ErrorMapper._();

  static AppError map(Object error) {
    if (error is AppError) return error;

    // Dio HTTP errors
    if (error is DioException) return _mapDioError(error);

    // Dart native
    if (error is SocketException) return const NetworkError();
    if (error is TimeoutException) return const TimeoutError();

    // Local database
    if (error is DatabaseException) return const DatabaseError();

    // Fallback
    return const UnknownError();
  }

  static AppError _mapDioError(DioException error) {
    if (error.response == null) {
      return switch (error.type) {
        DioExceptionType.connectionTimeout => const TimeoutError(),
        DioExceptionType.receiveTimeout => const TimeoutError(),
        DioExceptionType.sendTimeout => const TimeoutError(),
        DioExceptionType.connectionError => const NetworkError(),
        _ => const UnknownError(),
      };
    }

    return _mapHttpError(error.response!);
  }

  static AppError _mapHttpError(Response response) {
    final statusCode = response.statusCode ?? 500;
    final data = response.data;

    final businessError = _extractBusinessError(data);
    if (businessError != null) return businessError;

    return switch (statusCode) {
      401 => const UnauthorizedError(),
      403 => const ForbiddenError(),
      404 => NotFoundError(data?['resource'] ?? 'Resource'),
      422 => ServerValidationError(_parseFieldErrors(data)),
      _ when statusCode >= 500 => ServerError(statusCode),
      _ => const UnknownError(),
    };
  }

  static ApiBusinessError? _extractBusinessError(dynamic data) {
    if (data is! Map<String, dynamic>) return null;
    final errorCode = data['errorCode'] as String?;
    final success = data['success'] as bool?;

    if (errorCode != null) {
      return ApiBusinessError(
        errorCode: errorCode,
        message: data['message'] ?? ErrorMessages.operationFailed,
        details: data['details'],
      );
    }

    if (success == false) {
      return ApiBusinessError(
        errorCode: 'OPERATION_FAILED',
        message: data['message'] ?? ErrorMessages.operationFailed,
      );
    }

    return null;
  }

  static Map<String, String> _parseFieldErrors(dynamic data) {
    try {
      final errors = data?['errors'] as Map<String, dynamic>?;
      return errors?.map((k, v) => MapEntry(k, v.toString())) ?? {};
    } catch (_) {
      return {};
    }
  }
}
