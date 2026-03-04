import '../../modules/expense/domain/entities/expense.dart';
import 'expense_database.dart';

/// Mock Database Service for development/testing
/// Returns hardcoded test data instead of using real SQLite
class MockDatabaseService implements ExpenseDatabase {
  static final List<Expense> _mockExpenses = [
    Expense(
      id: 1,
      title: 'Grocery Shopping',
      amount: 45.50,
      category: 'Food',
      date: DateTime.now().subtract(const Duration(days: 2)),
      description: 'Weekly groceries',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Expense(
      id: 2,
      title: 'Gas Fill-up',
      amount: 60.00,
      category: 'Transportation',
      date: DateTime.now().subtract(const Duration(days: 1)),
      description: 'Fuel for the car',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Expense(
      id: 3,
      title: 'Restaurant Dinner',
      amount: 75.25,
      category: 'Food',
      date: DateTime.now(),
      description: 'Dinner with friends',
      createdAt: DateTime.now(),
    ),
    Expense(
      id: 4,
      title: 'Movie Tickets',
      amount: 30.00,
      category: 'Entertainment',
      date: DateTime.now(),
      description: 'Cinema tickets',
      createdAt: DateTime.now(),
    ),
    Expense(
      id: 5,
      title: 'Electric Bill',
      amount: 120.00,
      category: 'Utilities',
      date: DateTime.now().subtract(const Duration(days: 3)),
      description: 'Monthly electricity',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  int _nextId = 6;

  @override
  Future<List<Expense>> getAllExpenses() async {
    final list = List<Expense>.from(_mockExpenses);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  @override
  Future<int> insertExpense(Expense expense) async {
    final id = _nextId++;
    final withId = expense.copyWith(id: id);
    _mockExpenses.add(withId);
    return id;
  }

  @override
  Future<int> updateExpense(Expense expense) async {
    final idx = _mockExpenses.indexWhere((e) => e.id == expense.id);
    if (idx == -1) return 0;
    _mockExpenses[idx] = expense;
    return 1;
  }

  @override
  Future<int> deleteExpense(int id) async {
    final initialLength = _mockExpenses.length;
    _mockExpenses.removeWhere((e) => e.id == id);
    return _mockExpenses.length < initialLength ? 1 : 0;
  }

  @override
  Future<Expense?> getExpenseById(int id) async {
    try {
      return _mockExpenses.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> close() async {
    // No-op for mock
  }
}
