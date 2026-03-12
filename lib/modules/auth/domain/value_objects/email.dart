import 'package:flutter/material.dart';

import '../../../../core/errors/app_error.dart';

@immutable
class Email {
  const Email._(this.value);

  factory Email.create(String value) {
    if (value.isEmpty || !value.contains('@')) {
      throw ValidationError({'email': 'Invalid email format'});
    }
    return Email._(value);
  }

  final String value;
}
