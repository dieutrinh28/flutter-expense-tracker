import 'package:flutter/material.dart';

import '../config/form_config.dart';
import '../config/form_config_builder.dart';
import '../models/expense_form_data.dart';
import 'expense_fields/amount_field.dart';
import 'expense_fields/category_field.dart';
import 'expense_fields/date_field.dart';
import 'expense_fields/note_field.dart';
import 'expense_fields/payment_method_field.dart';
import 'expense_fields/title_field.dart';

class ExpenseForm extends StatelessWidget {
  final FormConfig formConfig;
  final ExpenseFormData formData;
  final void Function(String key, dynamic value) onFieldChanged;
  final Map<String, String> validationErrors;

  const ExpenseForm({
    required this.formConfig,
    required this.formData,
    required this.onFieldChanged,
    this.validationErrors = const {},
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isVisible(ExpenseFieldKey.amount))
          AmountField(
            value: formData.amount,
            isEditable: _isEditable(ExpenseFieldKey.amount),
            onChanged: (val) => onFieldChanged(ExpenseFieldKey.amount, val),
            errorText: validationErrors[ExpenseFieldKey.amount],
          ),
        const SizedBox(height: 24),
        if (_isVisible(ExpenseFieldKey.title))
          TitleField(
            value: formData.title,
            isEditable: _isEditable(ExpenseFieldKey.title),
            onChanged: (val) => onFieldChanged(ExpenseFieldKey.title, val),
            errorText: validationErrors[ExpenseFieldKey.title],
          ),
        const SizedBox(height: 24),
        if (_isVisible(ExpenseFieldKey.category))
          CategoryField(
            value: formData.categoryId,
            isEditable: _isEditable(ExpenseFieldKey.category),
            onChanged: (val) => onFieldChanged(ExpenseFieldKey.category, val),
            errorText: validationErrors[ExpenseFieldKey.category],
          ),
        const SizedBox(height: 24),
        if (_isVisible(ExpenseFieldKey.date))
          DateField(
            value: formData.date,
            isEditable: _isEditable(ExpenseFieldKey.date),
            onChanged: (val) => onFieldChanged(ExpenseFieldKey.date, val),
            errorText: validationErrors[ExpenseFieldKey.date],
          ),
        const SizedBox(height: 24),
        if (_isVisible(ExpenseFieldKey.paymentMethod))
          PaymentMethodField(
            value: formData.paymentMethod,
            isEditable: _isEditable(ExpenseFieldKey.paymentMethod),
            onChanged: (val) => onFieldChanged(ExpenseFieldKey.paymentMethod, val),
            errorText: validationErrors[ExpenseFieldKey.paymentMethod],
          ),
        const SizedBox(height: 24),
        if (_isVisible(ExpenseFieldKey.note))
          NoteField(
            value: formData.note,
            isEditable: _isEditable(ExpenseFieldKey.note),
            onChanged: (val) => onFieldChanged(ExpenseFieldKey.note, val),
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  bool _isVisible(String key) => formConfig.field(key)?.isVisible ?? true;

  bool _isEditable(String key) => formConfig.field(key)?.isEditable ?? true;
}
