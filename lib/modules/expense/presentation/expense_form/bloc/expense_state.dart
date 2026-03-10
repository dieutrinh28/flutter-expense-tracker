part of 'expense_bloc.dart';

sealed class ExpenseState {
  const ExpenseState();
}

class ExpenseInitial extends ExpenseState {
  const ExpenseInitial();
}

class ExpenseLoading extends ExpenseState {
  const ExpenseLoading();
}

class ExpenseLoaded extends ExpenseState {
  const ExpenseLoaded({
    required this.expense,
    required this.formData,
    required this.formConfig,
  });
  final ExpenseDetail? expense;
  final ExpenseFormData formData;
  final FormConfig formConfig;
}

class ExpenseEditing extends ExpenseState {
  const ExpenseEditing({
    required this.formData,
    required this.formConfig,
    this.validationErrors = const {},
  });
  final ExpenseFormData formData;
  final FormConfig formConfig;
  final Map<String, String> validationErrors;

  bool get isValid => validationErrors.isEmpty;
}

class ExpenseSaving extends ExpenseState {
  const ExpenseSaving({required this.formData});
  final ExpenseFormData formData;
}

class ExpenseSaved extends ExpenseState {
  const ExpenseSaved({required this.saved});
  final Expense saved;
}

class ExpenseError extends ExpenseState {
  const ExpenseError({
    required this.message,
    this.previousFormData,
  });
  final String message;
  final ExpenseFormData? previousFormData;
}