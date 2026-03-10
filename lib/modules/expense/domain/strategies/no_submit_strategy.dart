import '../../presentation/expense_form/models/expense_form_data.dart';
import '../entities/expense.dart';
import 'submit_strategy.dart';

class NoSubmitStrategy implements SubmitStrategy {
  const NoSubmitStrategy();

  @override
  Future<Expense> execute(ExpenseFormData formData) =>
      throw UnsupportedError('Submit is not allowed in this mode.');
}
