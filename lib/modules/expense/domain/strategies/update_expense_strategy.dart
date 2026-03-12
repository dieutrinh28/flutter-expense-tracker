import '../entities/expense.dart';
import '../usecases/update_expense.dart';
import '../value_objects/expense_input.dart';
import 'submit_strategy.dart';

class UpdateExpenseStrategy implements SubmitStrategy {
  const UpdateExpenseStrategy(this._useCase);
  final UpdateExpense _useCase;

  @override
  Future<Expense> execute(ExpenseInput input) async {
    if (input.id == null) throw ArgumentError('id required for update');
    final expense = Expense(
      id: input.id,
      title: input.title,
      amount: input.amount,
      categoryId: input.categoryId,
      date: input.date,
      note: input.note,
      createdAt: input.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return _useCase.call(expense);
  }
}
