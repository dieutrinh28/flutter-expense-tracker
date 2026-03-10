import '../../modules/expense/domain/entities/expense.dart';

/// Abstract interface for Expense Database
/// Allows swapping between real SQLite and mock implementations
abstract class ExpenseDatabase {
  Future<Expense> insertExpense(Expense expense);
  Future<Expense?> getExpenseById(String id);
  Future<List<Expense>> getAllExpenses();
  Future<Expense> updateExpense(Expense expense);
  Future<int> deleteExpense(String id);
  Future<void> close();
}
