import '../../modules/expense/data/models/expense_detail_dto.dart';
import '../../modules/expense/data/models/expense_dto.dart';

/// Abstract interface for Expense Database
/// Allows swapping between real SQLite and mock implementations
abstract class ExpenseDatabase {
  Future<ExpenseDto> insertExpense(ExpenseDto expense);
  Future<ExpenseDetailDto?> getExpenseById(String id);
  Future<List<ExpenseDto>> getAllExpenses();
  Future<ExpenseDto> updateExpense(ExpenseDto expense);
  Future<void> deleteExpense(String id);
  Future<void> close();
}
