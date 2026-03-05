sealed class ApiResponse<T> {
  const ApiResponse();
}

class ApiSuccess<T> extends ApiResponse<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResponse<T> {
  final String errorCode;
  final String message;
  final Map<String, dynamic>? details;

  const ApiFailure({
    required this.errorCode,
    required this.message,
    this.details,
  });
}

class ApiResponseParser {
  ApiResponseParser._();

  static ApiResponse<T> parse<T>(
    Map<String, dynamic> json,
    T Function(dynamic data) fromData,
  ) {
    final errorCode = json['errorCode'] as String?;
    final success = json['success'] as bool?;

    final hasError = success == false || errorCode != null;

    if (hasError) {
      return ApiFailure(
        errorCode: errorCode ?? 'OPERATION_FAILED',
        message: json['message'] ?? 'Operation failed.',
        details: json['details'],
      );
    }

    return ApiSuccess(fromData(json['data']));
  }
}
