import '../repositories/expense_repository.dart';

class DeleteExpense {
  final ExpenseRepository _repository;

  const DeleteExpense(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteExpense(id);
  }
}
