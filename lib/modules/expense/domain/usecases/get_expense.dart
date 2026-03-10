import '../entities/expense_detail.dart';
import '../repositories/expense_repository.dart';

class GetExpense {
  const GetExpense(this._repository);

  final ExpenseRepository _repository;

  Future<ExpenseDetail?> execute(String id) async {
    return _repository.getById(id);
  }
}