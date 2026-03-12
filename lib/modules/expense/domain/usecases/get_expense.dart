import '../entities/expense_detail.dart';
import '../repositories/expense_repository.dart';

class GetExpense {
  final ExpenseRepository _repository;

  const GetExpense(this._repository);

  Future<ExpenseDetail?> call(String id) async {
    return _repository.getById(id);
  }
}
