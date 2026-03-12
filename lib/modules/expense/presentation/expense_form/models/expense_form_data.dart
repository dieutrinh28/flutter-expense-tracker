import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ExpenseFormData extends Equatable {
  final String? id;
  final double amount;
  final String title;
  final String categoryId;
  final DateTime? date;
  final String? paymentMethod;
  final String? note;
  final String? receiptUrl;
  final String? merchant;
  final List<String> tags;

  const ExpenseFormData({
    this.id,
    this.amount = 0,
    this.title = '',
    this.categoryId = '',
    this.date,
    this.paymentMethod,
    this.note,
    // Detail-only fields
    this.receiptUrl,
    this.merchant,
    this.tags = const [],
  });

  factory ExpenseFormData.empty() => ExpenseFormData(
        date: DateTime.now(),
      );

  static const _remove = Object();

  ExpenseFormData copyWith({
    String? id,
    double? amount,
    String? title,
    String? categoryId,
    DateTime? date,
    Object? paymentMethod = _remove,
    Object? note = _remove,
    String? receiptUrl,
    String? merchant,
    List<String>? tags,
  }) {
    return ExpenseFormData(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      paymentMethod: paymentMethod == _remove
          ? this.paymentMethod
          : paymentMethod as String?,
      note: note == _remove ? this.note : note as String?,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      merchant: merchant ?? this.merchant,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        title,
        categoryId,
        date,
        paymentMethod,
        note,
        receiptUrl,
        merchant,
        tags,
      ];
}
