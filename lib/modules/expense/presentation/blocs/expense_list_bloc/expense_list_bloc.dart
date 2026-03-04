import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/usecases/add_expense.dart';
import '../../../domain/usecases/delete_expense.dart';
import '../../../domain/usecases/get_expenses.dart';
import '../../../domain/usecases/update_expense.dart';


part 'expense_list_event.dart';
part 'expense_list_state.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  final GetExpenses getExpenses;
  final AddExpense addExpense;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;

  ExpenseListBloc({
    required this.getExpenses,
    required this.addExpense,
    required this.updateExpense,
    required this.deleteExpense,
  }) : super(const ExpenseListInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpenseEvent>(_onAddExpense);
    on<UpdateExpenseEvent>(_onUpdateExpense);
    on<DeleteExpenseEvent>(_onDeleteExpense);
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(const ExpenseListLoading());
    try {
      final expenses = await getExpenses();
      if (expenses.isEmpty) {
        emit(const ExpenseListEmpty());
      } else {
        emit(ExpenseListLoaded(expenses));
      }
    } catch (e) {
      emit(ExpenseListError(e.toString()));
    }
  }

  Future<void> _onAddExpense(
    AddExpenseEvent event,
    Emitter<ExpenseListState> emit,
  ) async {
    try {
      await addExpense(event.expense);
      add(const LoadExpenses());
    } catch (e) {
      emit(ExpenseListError(e.toString()));
    }
  }

  Future<void> _onUpdateExpense(
    UpdateExpenseEvent event,
    Emitter<ExpenseListState> emit,
  ) async {
    try {
      await updateExpense(event.expense);
      add(const LoadExpenses());
    } catch (e) {
      emit(ExpenseListError(e.toString()));
    }
  }

  Future<void> _onDeleteExpense(
    DeleteExpenseEvent event,
    Emitter<ExpenseListState> emit,
  ) async {
    try {
      await deleteExpense(event.id);
      add(const LoadExpenses());
    } catch (e) {
      emit(ExpenseListError(e.toString()));
    }
  }
}
