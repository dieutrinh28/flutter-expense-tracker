import '../../domain/entities/expense.dart';

class ExpenseModel {
  final int? id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ExpenseModel({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      date: DateTime.parse(map['date'] as String),
      description: map['description'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at'] as String) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'amount': amount,
      'category': category,
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
      category: category,
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
      category: e.category,
      date: e.date,
      description: e.description,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }
}
