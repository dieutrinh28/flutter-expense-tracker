import 'package:expense_tracker/modules/expense/data/models/expense_model.dart';

import '../../domain/entities/expense.dart';
import 'expense_local_ds.dart';

class MockExpenseLocalDataSource implements ExpenseLocalDataSource {
  final List<ExpenseModel> _expenses = [
    ExpenseModel(
      id: '1',
      title: 'Grocery Shopping',
      amount: 85.50,
      categoryId: 'Food',
      date: DateTime(2025, 3, 1),
      description: 'Weekly groceries at supermarket',
      createdAt: DateTime(2025, 3, 1),
    ),
    ExpenseModel(
      id: '2',
      title: 'Electricity Bill',
      amount: 120.00,
      categoryId: 'Utilities',
      date: DateTime(2025, 3, 3),
      description: 'Monthly electricity payment',
      createdAt: DateTime(2025, 3, 3),
    ),
    ExpenseModel(
      id: '3',
      title: 'Uber Ride',
      amount: 15.75,
      categoryId: 'Transport',
      date: DateTime(2025, 3, 5),
      description: 'Ride to office',
      createdAt: DateTime(2025, 3, 5),
    ),
    ExpenseModel(
      id: '4',
      title: 'Netflix Subscription',
      amount: 13.99,
      categoryId: 'Entertainment',
      date: DateTime(2025, 3, 6),
      description: 'Monthly Netflix plan',
      createdAt: DateTime(2025, 3, 6),
    ),
    ExpenseModel(
      id: '5',
      title: 'Lunch with team',
      amount: 45.00,
      categoryId: 'Food',
      date: DateTime(2025, 3, 7),
      description: 'Team lunch at restaurant',
      createdAt: DateTime(2025, 3, 7),
    ),
    ExpenseModel(
      id: '6',
      title: 'Gym Membership',
      amount: 30.00,
      categoryId: 'Health',
      date: DateTime(2025, 3, 8),
      description: 'Monthly gym fee',
      createdAt: DateTime(2025, 3, 8),
    ),
  ];

  int _nextId = 7;

  @override
  Future<Expense> addExpense(ExpenseModel expense) async {
    final newExpense = expense.copyWith(id: (_nextId++).toString());
    _expenses.add(newExpense);
    return newExpense.toEntity();
  }

  @override
  Future<Expense> updateExpense(ExpenseModel expense) async {
    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index == -1) return expense.toEntity();
    _expenses[index] = expense;
    return expense.toEntity();
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    return List.unmodifiable(_expenses);
  }

  @override
  Future<ExpenseModel?> getById(String id) async {
    return _expenses.where((e) => e.id == id).firstOrNull;
  }

  @override
  Future<int> deleteExpense(String id) async {
    final index = _expenses.indexWhere((e) => e.id == id);
    if (index == -1) return 0;
    _expenses.removeAt(index);
    return 1;
  }
}
