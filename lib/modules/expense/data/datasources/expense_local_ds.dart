import '../../../../core/database/expense_database.dart';
import '../../../../core/database/database_service.dart';
import '../../../../core/database/mock_database_service.dart';
import '../models/expense_model.dart';

abstract class LocalExpenseDataSource {
  Future<int> addExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> getAllExpenses();
  Future<int> updateExpense(ExpenseModel expense);
  Future<int> deleteExpense(int id);
}

class LocalExpenseDataSourceImpl implements LocalExpenseDataSource {
  final ExpenseDatabase _dbService;

  // Constructor for real database
  LocalExpenseDataSourceImpl({ExpenseDatabase? dbService})
      : _dbService = dbService ?? DatabaseService();

  // Constructor for mock database
  LocalExpenseDataSourceImpl.mock(MockDatabaseService mockDbService)
      : _dbService = mockDbService;

  @override
  Future<int> addExpense(ExpenseModel expense) async {
    return await _dbService.insertExpense(expense.toEntity());
  }

  @override
  Future<int> deleteExpense(int id) async {
    return await _dbService.deleteExpense(id);
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    final list = await _dbService.getAllExpenses();
    return list.map((e) => ExpenseModel.fromEntity(e)).toList();
  }

  @override
  Future<int> updateExpense(ExpenseModel expense) async {
    return await _dbService.updateExpense(expense.toEntity());
  }
}

