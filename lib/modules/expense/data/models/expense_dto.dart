import 'package:flutter/material.dart';

import '../../domain/entities/expense.dart';

@immutable
class ExpenseDto {
  final String? id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? note;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ExpenseDto({
    this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.note,
    required this.createdAt,
    this.updatedAt,
  });

  ExpenseDto copyWith({
    String? id,
    String? title,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpenseDto(
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

  factory ExpenseDto.fromJson(Map<String, dynamic> json) {
    return ExpenseDto(
      id: json['id']?.toString(),
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      categoryId: json['categoryId']?.toString() ?? '',
      date: DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'categoryId': categoryId,
        'date': date.toIso8601String(),
        'note': note,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  Map<String, dynamic> toLocalJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'category_id': categoryId,
        'date': date.toIso8601String(),
        'note': note,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  Expense toDomain() => Expense(
        id: id,
        title: title,
        amount: amount,
        categoryId: categoryId,
        date: date,
        note: note,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory ExpenseDto.fromDomain(Expense e) => ExpenseDto(
        id: e.id,
        title: e.title,
        amount: e.amount,
        categoryId: e.categoryId,
        date: e.date,
        note: e.note,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
      );
}
