import '../entities/expense.dart';
import '../value_objects/expense_input.dart';
import 'submit_strategy.dart';

class NoSubmitStrategy implements SubmitStrategy {
  const NoSubmitStrategy();

  @override
  Future<Expense> execute(ExpenseInput input) =>
      throw UnsupportedError('Submit is not allowed in this mode.');
}
