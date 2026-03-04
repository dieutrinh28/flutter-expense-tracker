import '../database/expense_database.dart';
import '../database/database_service.dart';
import '../../modules/expense/data/datasources/expense_local_ds.dart';
import '../../modules/expense/data/repositories/expense_repository_impl.dart';
import '../../modules/expense/domain/usecases/add_expense.dart';
import '../../modules/expense/domain/usecases/delete_expense.dart';
import '../../modules/expense/domain/usecases/get_expenses.dart';
import '../../modules/expense/domain/usecases/update_expense.dart';

/// Manual Service Provider using Factory Pattern
/// All dependencies are lazily initialized as singletons
/// 
/// Located in core/di because DI is infrastructure layer,
/// which can depend on all other layers (presentation, domain, data, core).
class ServiceProvider {
  // Private constructor
  ServiceProvider._();

  // === Core Layer ===
  static final ExpenseDatabase _dbService = DatabaseService();

  // === Data Layer ===
  static final LocalExpenseDataSourceImpl _localDatasource =
      LocalExpenseDataSourceImpl(dbService: _dbService);

  // === Repository Layer ===
  static final ExpenseRepositoryImpl _expenseRepo =
      ExpenseRepositoryImpl(local: _localDatasource);

  // === Domain Layer - UseCases ===
  static final GetExpenses _getExpenses = GetExpenses(_expenseRepo);
  static final AddExpense _addExpense = AddExpense(_expenseRepo);
  static final UpdateExpense _updateExpense = UpdateExpense(_expenseRepo);
  static final DeleteExpense _deleteExpense = DeleteExpense(_expenseRepo);

  // === Public getters ===
  static ExpenseDatabase get expenseDatabase => _dbService;

  static LocalExpenseDataSource get localExpenseDatasource => _localDatasource;

  static ExpenseRepositoryImpl get expenseRepository => _expenseRepo;

  static GetExpenses get getExpenses => _getExpenses;
  static AddExpense get addExpense => _addExpense;
  static UpdateExpense get updateExpense => _updateExpense;
  static DeleteExpense get deleteExpense => _deleteExpense;

}

