import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final String? id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'categoryId': categoryId,
      'date': date.toIso8601String(),
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id']?.toString(),
      title: json['title'],
      amount: json['amount'].toDouble(),
      categoryId: json['categoryId'].toString(),
      date: DateTime.parse(json['date']),
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    categoryId,
    date,
    description,
    createdAt,
    updatedAt,
  ];
}
