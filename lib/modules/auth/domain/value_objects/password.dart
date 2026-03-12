import 'package:flutter/material.dart';

import '../../../../core/errors/app_error.dart';

@immutable
class Password {
  const Password._(this.value);

  factory Password.create(String value) {
    if (value.length < 6) {
      throw ValidationError({'password': 'Password too short'});
    }
    return Password._(value);
  }

  final String value;
}
