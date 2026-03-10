part of 'expense_bloc.dart';

sealed class ExpenseEvent {
  const ExpenseEvent();
}

class InitializeForm extends ExpenseEvent {
  const InitializeForm();
}

class LoadExpense extends ExpenseEvent {
  const LoadExpense({required this.id});
  final String id;
}

class FieldChanged extends ExpenseEvent {
  const FieldChanged({required this.key, required this.value});
  final String key;
  final dynamic value;
}

class SubmitExpense extends ExpenseEvent {
  const SubmitExpense();
}

class DeleteExpenseRequested extends ExpenseEvent {
  const DeleteExpenseRequested({required this.id});
  final String id;
}

class ConfirmDeleteExpense extends ExpenseEvent {
  const ConfirmDeleteExpense({required this.id});
  final String id;
}

class EditTapped extends ExpenseEvent {
  const EditTapped();
}

class DiscardChanges extends ExpenseEvent {
  const DiscardChanges();
}
