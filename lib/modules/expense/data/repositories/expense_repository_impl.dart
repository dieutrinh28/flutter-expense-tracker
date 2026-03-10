import 'package:expense_tracker/modules/expense/domain/entities/expense_detail.dart';

import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_local_ds.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource _local;

  ExpenseRepositoryImpl({required ExpenseLocalDataSource local}) : _local = local;

  @override
  Future<Expense> addExpense(Expense expense) async {
    final model = ExpenseModel.fromEntity(expense);
    return await _local.addExpense(model);
  }

  @override
  Future<Expense> updateExpense(Expense expense) async {
    final model = ExpenseModel.fromEntity(expense);
    return await _local.updateExpense(model);
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final models = await _local.getAllExpenses();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ExpenseDetail?> getById(String id) async {
    final expense = await _local.getById(id);
    // todo:
    return null;
  }

  @override
  Future<int> deleteExpense(String id) async {
    return await _local.deleteExpense(id);
  }

}
