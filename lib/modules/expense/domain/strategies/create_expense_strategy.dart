import '../entities/expense.dart';
import '../usecases/add_expense.dart';
import '../value_objects/expense_input.dart';
import 'submit_strategy.dart';

class CreateExpenseStrategy implements SubmitStrategy {
  const CreateExpenseStrategy(this._useCase);
  final AddExpense _useCase;

  @override
  Future<Expense> execute(ExpenseInput input) async {
    final expense = Expense(
      title: input.title,
      amount: input.amount,
      categoryId: input.categoryId,
      date: input.date,
      note: input.note,
      createdAt: DateTime.now(),
    );
    return _useCase.call(expense);
  }
}
