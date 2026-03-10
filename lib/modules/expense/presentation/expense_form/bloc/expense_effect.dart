part of 'expense_bloc.dart';

sealed class ExpenseEffect {
  const ExpenseEffect();
}

class NavigateBack extends ExpenseEffect {
  const NavigateBack();
}

class NavigateToEdit extends ExpenseEffect {
  const NavigateToEdit({required this.expenseId});
  final String expenseId;
}

class ShowSuccessToast extends ExpenseEffect {
  const ShowSuccessToast({required this.message});
  final String message;
}

class ShowErrorDialog extends ExpenseEffect {
  const ShowErrorDialog({
    required this.title,
    required this.body,
    this.retryAction,
  });
  final String title;
  final String body;
  final VoidCallback? retryAction;
}

class ShowDeleteConfirmation extends ExpenseEffect {
  const ShowDeleteConfirmation({required this.expenseId});
  final String expenseId;
}
