part of 'expense_list_bloc.dart';

abstract class ExpenseListEvent extends Equatable {
  const ExpenseListEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseListEvent {
  const LoadExpenses();
}

class AddExpenseEvent extends ExpenseListEvent {
  final Expense expense;

  const AddExpenseEvent(this.expense);

  @override
  List<Object?> get props => [expense];
}

class UpdateExpenseEvent extends ExpenseListEvent {
  final Expense expense;

  const UpdateExpenseEvent(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpenseEvent extends ExpenseListEvent {
  final int id;

  const DeleteExpenseEvent(this.id);

  @override
  List<Object?> get props => [id];
}
