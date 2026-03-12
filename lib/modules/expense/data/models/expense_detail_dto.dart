import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/entities/expense_detail.dart';
import 'expense_dto.dart';

@immutable
class ExpenseDetailDto extends ExpenseDto {
  const ExpenseDetailDto({
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
  ExpenseDetailDto copyWith({
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
    return ExpenseDetailDto(
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

  factory ExpenseDetailDto.fromJson(Map<String, dynamic> json) {
    return ExpenseDetailDto(
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
      receiptUrl: json['receiptUrl'] as String?,
      merchant: json['merchant'] as String?,
      tags: _parseTags(json['tags']),
    );
  }

  static List<String> _parseTags(dynamic value) {
    if (value == null) return [];
    if (value is List) return List<String>.from(value);
    if (value is String) return List<String>.from(jsonDecode(value));
    return [];
  }

  @override
  Map<String, dynamic> toLocalJson() => {
        ...super.toLocalJson(),
        'receipt_url': receiptUrl,
        'merchant': merchant,
        'tags': jsonEncode(tags),
      };

  Map<String, dynamic> toRemoteJson() => {
        ...super.toJson(),
        'receiptUrl': receiptUrl,
        'merchant': merchant,
        'tags': tags,
      };

  @override
  ExpenseDetail toDomain() => ExpenseDetail(
        id: id,
        title: title,
        amount: amount,
        categoryId: categoryId,
        date: date,
        note: note,
        createdAt: createdAt,
        updatedAt: updatedAt,
        receiptUrl: receiptUrl,
        merchant: merchant,
        tags: tags,
      );

  factory ExpenseDetailDto.fromDomain(ExpenseDetail e) => ExpenseDetailDto(
        id: e.id,
        title: e.title,
        amount: e.amount,
        categoryId: e.categoryId,
        date: e.date,
        note: e.note,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
        receiptUrl: e.receiptUrl,
        merchant: e.merchant,
        tags: e.tags,
      );

  factory ExpenseDetailDto.fromDto(ExpenseDto dto) => ExpenseDetailDto(
        id: dto.id,
        title: dto.title,
        amount: dto.amount,
        categoryId: dto.categoryId,
        date: dto.date,
        note: dto.note,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        tags: [],
      );
}
