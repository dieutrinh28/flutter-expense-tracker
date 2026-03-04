import '../../modules/expense/domain/entities/expense.dart';

/// Abstract interface for Expense Database
/// Allows swapping between real SQLite and mock implementations
abstract class ExpenseDatabase {
  Future<int> insertExpense(Expense expense);
  Future<Expense?> getExpenseById(int id);
  Future<List<Expense>> getAllExpenses();
  Future<int> updateExpense(Expense expense);
  Future<int> deleteExpense(int id);
  Future<void> close();
}
