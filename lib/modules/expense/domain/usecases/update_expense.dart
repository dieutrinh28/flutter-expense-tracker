import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class UpdateExpense {
  final ExpenseRepository _repository;

  const UpdateExpense(this._repository);

  Future<Expense> call(Expense expense) async {
    return await _repository.updateExpense(expense);
  }
}
