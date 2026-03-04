import '../../domain/entities/expense.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_local_ds.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final LocalExpenseDataSource local;

  ExpenseRepositoryImpl({required this.local});

  @override
  Future<int> addExpense(Expense expense) async {
    final model = ExpenseModel.fromEntity(expense);
    return await local.addExpense(model);
  }

  @override
  Future<int> deleteExpense(int id) async {
    return await local.deleteExpense(id);
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final models = await local.getAllExpenses();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<int> updateExpense(Expense expense) async {
    final model = ExpenseModel.fromEntity(expense);
    return await local.updateExpense(model);
  }
}
