part of 'expense_list_bloc.dart';

sealed class ExpenseListEffect {}

class ShowDeleteSuccessEffect extends ExpenseListEffect {}

class ShowErrorDialog extends ExpenseListEffect {
  final String message;
  ShowErrorDialog(this.message);
}
