import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Expense extends Equatable {
  final String? id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? note;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.note,
    required this.createdAt,
    this.updatedAt,
  });

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        amount,
        categoryId,
        date,
        note,
        createdAt,
        updatedAt,
      ];
}
