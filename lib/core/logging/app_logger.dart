import 'package:flutter/material.dart';

import '../errors/app_error.dart';

abstract class AppLogger {
  void error({
    required AppError error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  });
  void info(String message);
  void warning(String message);
}

class ConsoleLogger implements AppLogger {
  const ConsoleLogger();

  @override
  void error({
    required AppError error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    debugPrint('[${error.runtimeType}] ${error.message}');
    if (context != null) debugPrint('   Context: $context');
    if (stackTrace != null) debugPrint('   Stack: $stackTrace');
  }

  @override
  void info(String message) => debugPrint(message);

  @override
  void warning(String message) => debugPrint(message);
}
