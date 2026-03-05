part of 'expense_list_bloc.dart';

enum ExpenseOperation { none, loading, deleting }

class ExpenseListState extends Equatable {
  final List<Expense> expenses;
  final ExpenseOperation operation;
  final String? errorMessage;

  const ExpenseListState({
    this.expenses = const [],
    this.operation = ExpenseOperation.none,
    this.errorMessage,
  });

  bool get isLoading => operation == ExpenseOperation.loading;
  bool get isDeleting => operation == ExpenseOperation.deleting;
  bool get isEmpty => operation == ExpenseOperation.none && expenses.isEmpty;

  ExpenseListState copyWith({
    List<Expense>? expenses,
    ExpenseOperation? operation,
    String? errorMessage,
  }) =>
      ExpenseListState(
        expenses: expenses ?? this.expenses,
        operation: operation ?? this.operation,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
