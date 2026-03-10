import '../entities/expense.dart';
import '../entities/expense_detail.dart';

abstract class ExpenseRepository {
  Future<Expense> addExpense(Expense expense);

  Future<Expense> updateExpense(Expense expense);

  Future<List<Expense>> getExpenses();

  Future<ExpenseDetail?> getById(String id);

  Future<int> deleteExpense(String id);

}
