part of 'expense_list_bloc.dart';

abstract class ExpenseListState extends Equatable {
  const ExpenseListState();

  @override
  List<Object?> get props => [];
}

class ExpenseListInitial extends ExpenseListState {
  const ExpenseListInitial();
}

class ExpenseListLoading extends ExpenseListState {
  const ExpenseListLoading();
}

class ExpenseListLoaded extends ExpenseListState {
  final List<Expense> expenses;

  const ExpenseListLoaded(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class ExpenseListError extends ExpenseListState {
  final String message;

  const ExpenseListError(this.message);

  @override
  List<Object?> get props => [message];
}

class ExpenseListEmpty extends ExpenseListState {
  const ExpenseListEmpty();
}
