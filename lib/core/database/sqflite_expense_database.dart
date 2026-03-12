import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../modules/expense/data/models/expense_detail_dto.dart';
import '../../modules/expense/data/models/expense_dto.dart';
import 'expense_database.dart';

class SQLiteExpenseDatabase implements ExpenseDatabase {
  static final SQLiteExpenseDatabase _instance =
      SQLiteExpenseDatabase._internal();
  static Database? _database;

  factory SQLiteExpenseDatabase() {
    return _instance;
  }

  SQLiteExpenseDatabase._internal();

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expense_tracker.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        categoryId TEXT NOT NULL,
        date TEXT NOT NULL,
        note TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT,
        -- detail fields
        receipt_url TEXT,
        merchant TEXT,
        tags TEXT
      )
    ''');
  }

  // CRUD Operations for Expense

  @override
  Future<ExpenseDto> insertExpense(ExpenseDto expense) async {
    final db = await database;
    final id = expense.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final expenseWithId = expense.copyWith(id: id);

    await db.insert(
      'expenses',
      expenseWithId.toJson(),
    );

    return expenseWithId;
  }

  @override
  Future<ExpenseDetailDto?> getExpenseById(String id) async {
    final db = await database;
    final maps = await db.query(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return ExpenseDetailDto.fromJson(maps.first);
  }

  @override
  Future<List<ExpenseDto>> getAllExpenses() async {
    final db = await database;
    final maps = await db.query('expenses', orderBy: 'date DESC');
    return maps.map((map) => ExpenseDto.fromJson(map)).toList();
  }

  @override
  Future<ExpenseDto> updateExpense(ExpenseDto expense) async {
    final db = await database;

    final updatedExpense = expense.copyWith(updatedAt: DateTime.now());

    await db.update(
      'expenses',
      updatedExpense.toJson(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );

    return updatedExpense;
  }

  @override
  Future<void> deleteExpense(String id) async {
    final db = await database;
    final count = await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (count == 0) throw Exception('Expense not found: $id');
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
