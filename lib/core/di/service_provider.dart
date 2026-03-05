import '../database/expense_database.dart';
import '../database/database_service.dart';
import '../../modules/expense/data/datasources/expense_local_ds.dart';
import '../../modules/expense/data/repositories/expense_repository_impl.dart';
import '../../modules/expense/domain/usecases/delete_expense.dart';
import '../../modules/expense/domain/usecases/get_expenses.dart';
import '../logging/app_logger.dart';
import '../utils/bloc_safe_runner.dart';

/// Manual Service Provider using Factory Pattern
/// All dependencies are lazily initialized as singletons
/// 
/// Located in core/di because DI is infrastructure layer,
/// which can depend on all other layers (presentation, domain, data, core).
class ServiceProvider {
  ServiceProvider._();

  // === Infrastructure ===
  static late final AppLogger _logger;
  static late final BlocSafeRunner _blocSafeRunner;

  // === Core Layer ===
  static late final ExpenseDatabase _dbService;

  // === Data Layer ===
  static late final LocalExpenseDataSourceImpl _localDatasource;

  // === Repository Layer ===
  static late final ExpenseRepositoryImpl _expenseRepo;

  // === Domain Layer - UseCases ===
  static late final GetExpenses _getExpenses;
  static late final DeleteExpense _deleteExpense;

  static Future<void> initialize() async {
    _logger = ConsoleLogger();
    _blocSafeRunner = BlocSafeRunner(logger: _logger);
    _dbService = DatabaseService();

    _localDatasource = LocalExpenseDataSourceImpl(dbService: _dbService);
    _expenseRepo = ExpenseRepositoryImpl(local: _localDatasource);

    _getExpenses = GetExpenses(_expenseRepo);
    _deleteExpense = DeleteExpense(_expenseRepo);
  }

  // === Public getters ===
  static BlocSafeRunner get blocSafeRunner => _blocSafeRunner;
  static AppLogger get logger => _logger;

  static ExpenseDatabase get expenseDatabase => _dbService;
  static LocalExpenseDataSource get localExpenseDatasource => _localDatasource;
  static ExpenseRepositoryImpl get expenseRepository => _expenseRepo;

  static GetExpenses get getExpenses => _getExpenses;
  static DeleteExpense get deleteExpense => _deleteExpense;

}

