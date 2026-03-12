import '../../../../core/database/expense_database.dart';
import '../models/expense_detail_dto.dart';
import '../models/expense_dto.dart';

abstract class ExpenseLocalDataSource {
  Future<ExpenseDto> addExpense(ExpenseDto expense);
  Future<ExpenseDto> updateExpense(ExpenseDto expense);
  Future<List<ExpenseDto>> getAllExpenses();
  Future<ExpenseDetailDto?> getById(String id);
  Future<void> deleteExpense(String id);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final ExpenseDatabase _dbService;

  ExpenseLocalDataSourceImpl({required ExpenseDatabase dbService})
      : _dbService = dbService;

  @override
  Future<ExpenseDto> addExpense(ExpenseDto expense) async {
    return await _dbService.insertExpense(expense);
  }

  @override
  Future<ExpenseDto> updateExpense(ExpenseDto expense) async {
    return await _dbService.updateExpense(expense);
  }

  @override
  Future<List<ExpenseDto>> getAllExpenses() async {
    return await _dbService.getAllExpenses();
  }

  @override
  Future<ExpenseDetailDto?> getById(String id) async {
    return await _dbService.getExpenseById(id);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _dbService.deleteExpense(id);
  }
}
