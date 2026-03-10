import 'package:flutter/material.dart';

import 'expense.dart';

@immutable
class ExpenseDetail extends Expense {
  const ExpenseDetail({
    required super.id,
    required super.title,
    required super.amount,
    required super.categoryId,
    required super.date,
    required super.createdAt,
    super.description,
    super.updatedAt,
    // Detail-only fields
    this.receiptUrl,
    this.merchant,
    this.tags = const [],
  });

  final String? receiptUrl;
  final String? merchant;
  final List<String> tags;
}
