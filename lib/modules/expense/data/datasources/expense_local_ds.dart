import '../../../../core/database/expense_database.dart';
import '../../../../core/database/sqflite_expense_database.dart';
import '../../domain/entities/expense.dart';
import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<Expense> addExpense(ExpenseModel expense);
  Future<Expense> updateExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> getAllExpenses();
  Future<ExpenseModel?> getById(String id);
  Future<int> deleteExpense(String id);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final ExpenseDatabase _dbService;

  ExpenseLocalDataSourceImpl({ExpenseDatabase? dbService})
      : _dbService = dbService ?? SQLiteExpenseDatabase();

  @override
  Future<Expense> addExpense(ExpenseModel expense) async {
    return await _dbService.insertExpense(expense.toEntity());
  }

  @override
  Future<Expense> updateExpense(ExpenseModel expense) async {
    return await _dbService.updateExpense(expense.toEntity());
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    final list = await _dbService.getAllExpenses();
    return list.map((e) => ExpenseModel.fromEntity(e)).toList();
  }

  @override
  Future<ExpenseModel?> getById(String id) async {
    final expense = await _dbService.getExpenseById(id);
    if (expense != null) {
      return ExpenseModel.fromEntity(expense);
    }
    return null;
  }

  @override
  Future<int> deleteExpense(String id) async {
    return await _dbService.deleteExpense(id);
  }

}

