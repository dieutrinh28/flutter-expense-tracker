import '../entities/expense.dart';

abstract class ExpenseRepository {
  /// Inserts [expense] and returns the generated id.
  Future<int> addExpense(Expense expense);

  /// Returns all expenses ordered by date descending.
  Future<List<Expense>> getExpenses();

  /// Deletes expense by [id]. Returns number of rows affected (0 or 1).
  Future<int> deleteExpense(int id);

  /// Updates [expense]. Returns number of rows affected (0 or 1).
  Future<int> updateExpense(Expense expense);
}
