import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/utils/bloc_safe_runner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/usecases/delete_expense.dart';
import '../../../domain/usecases/get_expenses.dart';

part 'expense_list_event.dart';
part 'expense_list_state.dart';
part 'expense_list_effect.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  final GetExpenses getExpenses;
  final DeleteExpense deleteExpense;
  final BlocSafeRunner runner;

  final _effectController = StreamController<ExpenseListEffect>.broadcast();
  Stream<ExpenseListEffect> get effects => _effectController.stream;

  ExpenseListBloc({
    required this.getExpenses,
    required this.deleteExpense,
    required this.runner,
  }) : super(const ExpenseListState()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<DeleteExpenseEvent>(_onDeleteExpense);
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseListState> emit,
  ) async {
    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: state.copyWith(operation: ExpenseOperation.loading),
      action: () async {
        final expenses = await getExpenses();
        emit(state.copyWith(
          expenses: expenses,
          operation: ExpenseOperation.none,
        ));
      },
      onError: (error) => state.copyWith(
        operation: ExpenseOperation.none,
        errorMessage: error.message,
      ),
      errorEffect: (error) => ShowErrorEffect(error.message),
      logContext: {'bloc': 'ExpenseListBloc', 'event': 'LoadExpenses'},
    );
  }

  Future<void> _onDeleteExpense(
    DeleteExpenseEvent event,
    Emitter<ExpenseListState> emit,
  ) async {
    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: state.copyWith(operation: ExpenseOperation.deleting),
      action: () async {
        await deleteExpense(event.id);
        add(const LoadExpenses());
      },
      onError: (error) => state.copyWith(
        operation: ExpenseOperation.none,
        errorMessage: error.message,
      ),
      errorEffect: (error) => ShowErrorEffect(error.message),
      successEffect: ShowDeleteSuccessEffect(),
      logContext: {
        'bloc': 'ExpenseListBloc',
        'event': 'DeleteExpense',
        'id': event.id
      },
    );
  }

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }
}
