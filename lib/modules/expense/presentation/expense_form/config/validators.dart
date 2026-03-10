import 'field_validator.dart';

abstract final class Validators {
  static const FieldValidator positiveNumber = FieldValidator(
    errorKey: 'positive_number',
    validate: _validatePositiveNumber,
  );

  static String? _validatePositiveNumber(dynamic value) {
    if (value == null) return 'Value is required';
    final n =
        value is num ? value.toDouble() : double.tryParse(value.toString());
    if (n == null) return 'Must be a valid number';
    if (n <= 0) return 'Must be greater than zero';
    return null;
  }

  static const FieldValidator required = FieldValidator(
    errorKey: 'required',
    validate: _validateRequired,
  );

  static String? _validateRequired(dynamic value) {
    if (value == null) return 'This field is required';
    if (value is String && value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
