import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class AddExpense {
  final ExpenseRepository _repository;

  const AddExpense(this._repository);

  Future<Expense> call(Expense expense) async {
    return await _repository.addExpense(expense);
  }
}
