import '../entities/expense.dart';
import '../value_objects/expense_input.dart';

abstract interface class SubmitStrategy {
  Future<Expense> execute(ExpenseInput formData);
}
