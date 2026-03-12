import 'package:flutter/material.dart';

import 'field_validator.dart';
import 'screen_mode.dart';

@immutable
class FieldConfig {
  final String fieldKey;
  final bool isVisible;
  final bool isEditable;
  final bool isRequired;
  final List<FieldValidator> validators;

  const FieldConfig({
    required this.fieldKey,
    required this.isVisible,
    required this.isEditable,
    this.isRequired = false,
    this.validators = const [],
  });

  FieldConfig copyWith({
    bool? isVisible,
    bool? isEditable,
  }) =>
      FieldConfig(
        fieldKey: fieldKey,
        isVisible: isVisible ?? this.isVisible,
        isEditable: isEditable ?? this.isEditable,
        isRequired: isRequired,
        validators: validators,
      );
}

@immutable
class FormConfig {
  final ScreenMode mode;
  final Map<String, FieldConfig> fields;
  final bool showDetailSection;
  final bool isEditable;
  final bool showActionBar;

  const FormConfig({
    required this.mode,
    required this.fields,
    required this.showDetailSection,
    required this.isEditable,
    required this.showActionBar,
  });

  FieldConfig? field(String key) => fields[key];
}
