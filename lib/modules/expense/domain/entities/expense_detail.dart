import 'package:flutter/material.dart';

import 'expense.dart';

@immutable
class ExpenseDetail extends Expense {
  const ExpenseDetail({
    super.id,
    required super.title,
    required super.amount,
    required super.categoryId,
    required super.date,
    super.note,
    required super.createdAt,
    super.updatedAt,
    // Detail-only fields
    this.receiptUrl,
    this.merchant,
    this.tags = const [],
  });

  final String? receiptUrl;
  final String? merchant;
  final List<String> tags;

  @override
  ExpenseDetail copyWith({
    String? id,
    String? title,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? receiptUrl,
    String? merchant,
    List<String>? tags,
  }) {
    return ExpenseDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      merchant: merchant ?? this.merchant,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        receiptUrl,
        merchant,
        tags,
      ];
}
