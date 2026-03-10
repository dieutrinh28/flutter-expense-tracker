import 'package:flutter/material.dart';

typedef ValidatorFn = String? Function(dynamic value);

@immutable
class FieldValidator {
  final ValidatorFn validate;
  final String errorKey;

  const FieldValidator({
    required this.validate,
    required this.errorKey, // stable key for identifying which rule failed
  });

  String? call(dynamic value) => validate(value);
}
