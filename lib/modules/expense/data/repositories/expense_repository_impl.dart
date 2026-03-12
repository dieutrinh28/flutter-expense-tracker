import '../../domain/entities/expense.dart';
import '../../domain/entities/expense_detail.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_local_ds.dart';
import '../models/expense_dto.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource _local;

  ExpenseRepositoryImpl({required ExpenseLocalDataSource local})
      : _local = local;

  @override
  Future<Expense> addExpense(Expense expense) async {
    final dto = ExpenseDto.fromDomain(expense);
    final saved = await _local.addExpense(dto);
    return saved.toDomain();
  }

  @override
  Future<Expense> updateExpense(Expense expense) async {
    final dto = ExpenseDto.fromDomain(expense);
    final saved = await _local.updateExpense(dto);
    return saved.toDomain();
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final models = await _local.getAllExpenses();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<ExpenseDetail?> getById(String id) async {
    final dto = await _local.getById(id);
    return dto?.toDomain();
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _local.deleteExpense(id);
  }
}
