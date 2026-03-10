import '../repositories/expense_repository.dart';

class DeleteExpense {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  Future<int> call(String id) async {
    return await repository.deleteExpense(id);
  }
}
