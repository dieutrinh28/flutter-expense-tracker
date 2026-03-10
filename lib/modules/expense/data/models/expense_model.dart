import '../../domain/entities/expense.dart';

class ExpenseModel {
  final String? id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ExpenseModel({
    this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });

  ExpenseModel copyWith({
    String? id,
    String? title,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpenseModel(
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

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id']?.toString(),
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      categoryId: map['categoryId'].toString(),
      date: DateTime.parse(map['date'] as String),
      description: map['description'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'amount': amount,
      'categoryId': categoryId,
      'date': date.toIso8601String(),
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Expense toEntity() {
    return Expense(
      id: id,
      title: title,
      amount: amount,
      categoryId: categoryId,
      date: date,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ExpenseModel.fromEntity(Expense e) {
    return ExpenseModel(
      id: e.id,
      title: e.title,
      amount: e.amount,
      categoryId: e.categoryId,
      date: e.date,
      description: e.description,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }
}
