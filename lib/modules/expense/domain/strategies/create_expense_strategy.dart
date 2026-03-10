import '../../presentation/expense_form/models/expense_form_data.dart';
import '../entities/expense.dart';
import '../usecases/add_expense.dart';
import 'submit_strategy.dart';

class CreateExpenseStrategy implements SubmitStrategy {
  const CreateExpenseStrategy(this._useCase);
  final AddExpense _useCase;

  @override
  Future<Expense> execute(ExpenseFormData formData) async {
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
