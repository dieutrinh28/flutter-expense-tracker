import 'package:expense_tracker/modules/expense/data/datasources/mock_expense_local_ds.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/auth/data/datasources/auth_local_ds.dart';
import '../../modules/auth/data/datasources/auth_remote_ds.dart';
import '../../modules/auth/data/datasources/mock_auth_local_ds.dart';
import '../../modules/auth/data/datasources/mock_auth_remote_ds.dart';
import '../../modules/auth/data/repositories/auth_repository_impl.dart';
import '../../modules/auth/domain/repositories/auth_repository.dart';
import '../../modules/auth/domain/usecases/check_auth.dart';
import '../../modules/auth/domain/usecases/login.dart';
import '../../modules/auth/domain/usecases/logout.dart';
import '../../modules/expense/domain/repositories/expense_repository.dart';
import '../database/sqflite_expense_database.dart';
import '../database/expense_database.dart';
import '../../modules/expense/data/datasources/expense_local_ds.dart';
import '../../modules/expense/data/repositories/expense_repository_impl.dart';
import '../../modules/expense/domain/usecases/add_expense.dart';
import '../../modules/expense/domain/usecases/update_expense.dart';
import '../../modules/expense/domain/usecases/get_expense.dart';
import '../../modules/expense/domain/usecases/delete_expense.dart';
import '../../modules/expense/domain/usecases/get_expenses.dart';
import '../logging/app_logger.dart';
import '../network/dio_client.dart';
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
  static late final DioClient _dioClient;

  // === SharedPreferences ===
  static late final SharedPreferences _prefs;

  // === Auth ===
  static late final AuthRemoteDataSource _authRemote;
  static late final AuthLocalDataSource _authLocal;
  static late final AuthRepository _authRepo;
  static late final LoginUseCase _loginUseCase;
  static late final LogoutUseCase _logoutUseCase;
  static late final CheckAuthUseCase _checkAuthUseCase;

  // === Expense ===
  static late final ExpenseDatabase _dbService;
  static late final ExpenseLocalDataSource _localDatasource;
  static late final ExpenseRepository _expenseRepo;
  static late final GetExpenses _getExpenses;
  static late final DeleteExpense _deleteExpense;
  static late final AddExpense _addExpense;
  static late final UpdateExpense _updateExpense;
  static late final GetExpense _getExpense;

  static Future<void> initialize() async {
    // Infrastructure
    _logger = ConsoleLogger();
    _blocSafeRunner = BlocSafeRunner(logger: _logger);
    _dioClient = DioClient();
    _prefs = await SharedPreferences.getInstance();

    // Auth
    // _authRemote = AuthRemoteDataSourceImpl(_dioClient);
    // _authLocal = AuthLocalDataSourceImpl(_prefs);

    _authRemote = MockAuthRemoteDataSource();
    _authLocal = MockAuthLocalDataSource();
    _authRepo = AuthRepositoryImpl(remote: _authRemote, local: _authLocal);
    _loginUseCase = LoginUseCase(_authRepo);
    _logoutUseCase = LogoutUseCase(_authRepo);
    _checkAuthUseCase = CheckAuthUseCase(_authRepo);

    // Expense
    _dbService = SQLiteExpenseDatabase();
    // _localDatasource = ExpenseLocalDataSourceImpl(dbService: _dbService);

    _localDatasource = MockExpenseLocalDataSource();
    _expenseRepo = ExpenseRepositoryImpl(local: _localDatasource);
    _getExpenses = GetExpenses(_expenseRepo);
    _deleteExpense = DeleteExpense(_expenseRepo);
    _addExpense = AddExpense(_expenseRepo);
    _updateExpense = UpdateExpense(_expenseRepo);
    _getExpense = GetExpense(_expenseRepo);
  }

  // === Public getters ===

  // Infrastructure
  static BlocSafeRunner get blocSafeRunner => _blocSafeRunner;
  static AppLogger get logger => _logger;

  // Auth
  static LoginUseCase get loginUseCase => _loginUseCase;
  static LogoutUseCase get logoutUseCase => _logoutUseCase;
  static CheckAuthUseCase get checkAuthUseCase => _checkAuthUseCase;

  // Expense
  static GetExpenses get getExpenses => _getExpenses;
  static DeleteExpense get deleteExpense => _deleteExpense;
  static AddExpense get addExpense => _addExpense;
  static UpdateExpense get updateExpense => _updateExpense;
  static GetExpense get getExpense => _getExpense;
}
