part of 'expense_list_bloc.dart';

sealed class ExpenseListEffect {}

class ShowDeleteSuccessEffect extends ExpenseListEffect {}

class ShowErrorEffect extends ExpenseListEffect {
  final String message;
  ShowErrorEffect(this.message);
}
