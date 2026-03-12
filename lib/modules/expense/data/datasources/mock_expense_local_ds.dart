import '../models/expense_detail_dto.dart';
import '../models/expense_dto.dart';
import 'expense_local_ds.dart';

class MockExpenseLocalDataSource implements ExpenseLocalDataSource {
  final List<ExpenseDetailDto> _expenses = [
    ExpenseDetailDto(
      id: '1',
      title: 'Grocery Shopping',
      amount: 85.50,
      categoryId: 'Food',
      date: DateTime(2025, 3, 1),
      note: 'Weekly groceries at supermarket',
      createdAt: DateTime(2025, 3, 1),
    ),
    ExpenseDetailDto(
      id: '2',
      title: 'Electricity Bill',
      amount: 120.00,
      categoryId: 'Utilities',
      date: DateTime(2025, 3, 3),
      note: 'Monthly electricity payment',
      createdAt: DateTime(2025, 3, 3),
    ),
    ExpenseDetailDto(
      id: '3',
      title: 'Uber Ride',
      amount: 15.75,
      categoryId: 'Transport',
      date: DateTime(2025, 3, 5),
      note: 'Ride to office',
      createdAt: DateTime(2025, 3, 5),
    ),
    ExpenseDetailDto(
      id: '4',
      title: 'Netflix Subscription',
      amount: 13.99,
      categoryId: 'Entertainment',
      date: DateTime(2025, 3, 6),
      note: 'Monthly Netflix plan',
      createdAt: DateTime(2025, 3, 6),
    ),
    ExpenseDetailDto(
      id: '5',
      title: 'Lunch with team',
      amount: 45.00,
      categoryId: 'Food',
      date: DateTime(2025, 3, 7),
      note: 'Team lunch at restaurant',
      createdAt: DateTime(2025, 3, 7),
    ),
    ExpenseDetailDto(
      id: '6',
      title: 'Gym Membership',
      amount: 30.00,
      categoryId: 'Health',
      date: DateTime(2025, 3, 8),
      note: 'Monthly gym fee',
      createdAt: DateTime(2025, 3, 8),
    ),
  ];

  int _nextId = 7;

  @override
  Future<ExpenseDto> addExpense(ExpenseDto expense) async {
    final newExpense = expense.copyWith(id: (_nextId++).toString());
    _expenses.add(ExpenseDetailDto.fromDto(newExpense));
    return newExpense;
  }

  @override
  Future<ExpenseDto> updateExpense(ExpenseDto expense) async {
    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index == -1) throw Exception('Expense not found: ${expense.id}');
    _expenses[index] = ExpenseDetailDto.fromDto(expense);
    return expense;
  }

  @override
  Future<List<ExpenseDto>> getAllExpenses() async {
    return _expenses;
  }

  @override
  Future<ExpenseDetailDto?> getById(String id) async {
    return _expenses.where((e) => e.id == id).firstOrNull;
  }

  @override
  Future<void> deleteExpense(String id) async {
    final index = _expenses.indexWhere((e) => e.id == id);
    if (index == -1) throw Exception('Expense not found: $id');
    _expenses.removeAt(index);
  }
}
