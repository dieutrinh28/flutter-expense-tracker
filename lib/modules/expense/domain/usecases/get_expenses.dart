import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class GetExpenses {
  final ExpenseRepository _repository;

  const GetExpenses(this._repository);

  Future<List<Expense>> call() async {
    return await _repository.getExpenses();
  }
}
