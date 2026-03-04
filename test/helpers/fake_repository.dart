import 'package:expense_tracker/modules/expense/domain/entities/expense.dart';
import 'package:expense_tracker/modules/expense/domain/repositories/expense_repository.dart';

class FakeExpenseRepository implements ExpenseRepository {
  final List<Expense> testExpenses = [];
  int _autoIncId = 1;

  @override
  Future<int> addExpense(Expense expense) async {
    final id = _autoIncId++;
    final withId = expense.copyWith(id: id);
    testExpenses.add(withId);
    return id;
  }

  @override
  Future<int> deleteExpense(int id) async {
    final initialLength = testExpenses.length;
    testExpenses.removeWhere((e) => e.id == id);
    return testExpenses.length < initialLength ? 1 : 0;
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final list = List<Expense>.from(testExpenses);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  @override
  Future<int> updateExpense(Expense expense) async {
    final idx = testExpenses.indexWhere((e) => e.id == expense.id);
    if (idx == -1) return 0;
    testExpenses[idx] = expense;
    return 1;
  }
}
