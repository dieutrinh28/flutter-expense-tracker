import '../../presentation/expense_form/models/expense_form_data.dart';
import '../entities/expense.dart';

abstract interface class SubmitStrategy {
  Future<Expense> execute(ExpenseFormData formData);
}
