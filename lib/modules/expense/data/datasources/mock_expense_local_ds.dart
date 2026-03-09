import 'package:expense_tracker/modules/expense/data/models/expense_model.dart';

import 'expense_local_ds.dart';

class MockExpenseLocalDataSource implements ExpenseLocalDataSource {
  final List<ExpenseModel> _expenses = [
    ExpenseModel(
      id: 1,
      title: 'Grocery Shopping',
      amount: 85.50,
      category: 'Food',
      date: DateTime(2025, 3, 1),
      description: 'Weekly groceries at supermarket',
      createdAt: DateTime(2025, 3, 1),
    ),
    ExpenseModel(
      id: 2,
      title: 'Electricity Bill',
      amount: 120.00,
      category: 'Utilities',
      date: DateTime(2025, 3, 3),
      description: 'Monthly electricity payment',
      createdAt: DateTime(2025, 3, 3),
    ),
    ExpenseModel(
      id: 3,
      title: 'Uber Ride',
      amount: 15.75,
      category: 'Transport',
      date: DateTime(2025, 3, 5),
      description: 'Ride to office',
      createdAt: DateTime(2025, 3, 5),
    ),
    ExpenseModel(
      id: 4,
      title: 'Netflix Subscription',
      amount: 13.99,
      category: 'Entertainment',
      date: DateTime(2025, 3, 6),
      description: 'Monthly Netflix plan',
      createdAt: DateTime(2025, 3, 6),
    ),
    ExpenseModel(
      id: 5,
      title: 'Lunch with team',
      amount: 45.00,
      category: 'Food',
      date: DateTime(2025, 3, 7),
      description: 'Team lunch at restaurant',
      createdAt: DateTime(2025, 3, 7),
    ),
    ExpenseModel(
      id: 6,
      title: 'Gym Membership',
      amount: 30.00,
      category: 'Health',
      date: DateTime(2025, 3, 8),
      description: 'Monthly gym fee',
      createdAt: DateTime(2025, 3, 8),
    ),
  ];

  int _nextId = 7;

  @override
  Future<int> addExpense(ExpenseModel expense) async {
    final newExpense = expense.copyWith(id: _nextId++);
    _expenses.add(newExpense);
    return newExpense.id!;
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    print("do day nef");
    return List.unmodifiable(_expenses);
  }

  @override
  Future<int> updateExpense(ExpenseModel expense) async {
    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index == -1) return 0;
    _expenses[index] = expense;
    return 1;
  }

  @override
  Future<int> deleteExpense(int id) async {
    final index = _expenses.indexWhere((e) => e.id == id);
    if (index == -1) return 0;
    _expenses.removeAt(index);
    return 1;
  }
}
