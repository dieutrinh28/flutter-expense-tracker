class ErrorMessages {
  ErrorMessages._();

  // Network
  static const network = 'No internet connection.';
  static const timeout = 'Request timed out. Please try again.';

  // HTTP
  static const unauthorized = 'Session expired. Please login again.';
  static const forbidden = 'You do not have permission.';
  static const serverError = 'Server error. Please try later.';

  // Business fallback
  static const operationFailed = 'Something went wrong. Please try again.';
  static const validationFailed = 'Please check your input.';
  static const unknown = 'Something went wrong. Please try again.';
}
