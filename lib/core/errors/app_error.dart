import 'error_messages.dart';

sealed class AppError {
  final String message;
  const AppError(this.message);
}

// --- Network ---
class NetworkError extends AppError {
  const NetworkError() : super(ErrorMessages.network);
}

class TimeoutError extends AppError {
  const TimeoutError() : super(ErrorMessages.timeout);
}

// --- HTTP Status ---
class UnauthorizedError extends AppError {
  const UnauthorizedError() : super(ErrorMessages.unauthorized);
}

class ForbiddenError extends AppError {
  const ForbiddenError() : super('You do not have permission.');
}

class NotFoundError extends AppError {
  const NotFoundError(String item) : super('$item not found.');
}

class ServerValidationError extends AppError {
  final Map<String, String> fieldErrors;
  const ServerValidationError(this.fieldErrors)
      : super('Please check your input.');
}

class ServerError extends AppError {
  final int statusCode;
  const ServerError(this.statusCode) : super('Server error. Please try later.');
}

// --- Business (từ backend errorCode) ---
class ApiBusinessError extends AppError {
  final String errorCode;
  final Map<String, dynamic>? details;

  const ApiBusinessError({
    required this.errorCode,
    required String message,
    this.details,
  }) : super(message);
}

// --- Client-side ---
class ValidationError extends AppError {
  final Map<String, String> fieldErrors;
  const ValidationError(this.fieldErrors) : super('Please check your input.');
}

class DatabaseError extends AppError {
  const DatabaseError() : super('Failed to save data locally.');
}

class UnknownError extends AppError {
  const UnknownError() : super('Something went wrong. Please try again.');
}
