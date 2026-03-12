import 'package:flutter/material.dart';

@immutable
class ExpenseInput {
  final String? id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? note;
  final String? paymentMethod;
  final DateTime? createdAt;

  const ExpenseInput({
    this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.note,
    this.paymentMethod,
    this.createdAt,
  });
}
