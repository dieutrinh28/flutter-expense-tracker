import '../../presentation/expense_form/models/expense_form_data.dart';
import '../entities/expense.dart';
import '../usecases/update_expense.dart';
import 'submit_strategy.dart';

class UpdateExpenseStrategy implements SubmitStrategy {
  const UpdateExpenseStrategy(this._useCase);
  final UpdateExpense _useCase;

  @override
  Future<Expense> execute(ExpenseFormData formData) async {
    if (formData.id == null) throw ArgumentError('id required for update');
    // todo:
    final expense = Expense(
      title: "",
      amount: 0,
      categoryId: 'Food',
      date: DateTime.now(),
      createdAt: DateTime.now(),
    );
    return _useCase.call(expense);
  }
}
