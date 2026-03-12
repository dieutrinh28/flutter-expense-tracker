import 'dart:async';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/bloc_safe_runner.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/entities/expense_detail.dart';
import '../../../domain/strategies/submit_strategy.dart';
import '../../../domain/usecases/delete_expense.dart';
import '../../../domain/usecases/get_expense.dart';
import '../../../domain/value_objects/expense_input.dart';
import '../config/form_config.dart';
import '../config/form_config_builder.dart';
import '../config/screen_mode.dart';
import '../models/expense_form_data.dart';

part 'expense_event.dart';
part 'expense_state.dart';
part 'expense_effect.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ScreenMode mode;
  final GetExpense getExpense;
  final DeleteExpense deleteExpense;
  final SubmitStrategy submitStrategy;
  final FormConfigBuilder formConfigBuilder;
  final BlocSafeRunner runner;

  ExpenseBloc({
    required this.mode,
    required this.getExpense,
    required this.deleteExpense,
    required this.submitStrategy, // injected based on mode
    required this.formConfigBuilder,
    required this.runner,
  }) : super(const ExpenseInitial()) {
    on<InitializeForm>(_onInitialize);
    on<LoadExpense>(_onLoad);
    on<FieldChanged>(_onFieldChanged);
    on<SubmitExpense>(_onSubmit);
    on<DeleteExpenseRequested>(_onDeleteRequested);
    on<ConfirmDeleteExpense>(_onConfirmDelete);
    on<EditTapped>(_onEditTapped);
    on<DiscardChanges>(_onDiscardChanges);

    if (mode == ScreenMode.create) {
      add(const InitializeForm());
    }
  }

  final _effectController = StreamController<ExpenseEffect>.broadcast();
  Stream<ExpenseEffect> get effects => _effectController.stream;

  late final FormConfig formConfig = formConfigBuilder.build(mode);

  ExpenseDetail? _originalDetail;

  Future<void> _onInitialize(
    InitializeForm event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseEditing(
      formData: ExpenseFormData.empty(),
      formConfig: formConfig,
    ));
  }

  Future<void> _onLoad(
    LoadExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: const ExpenseLoading(),
      action: () async {
        final detail = await getExpense.call(event.id);
        _originalDetail = detail;

        // Convert detail back to formData for the form
        final formData = ExpenseFormData(
          id: detail?.id,
          title: detail?.title ?? "",
          amount: detail?.amount ?? 0,
          categoryId: detail?.categoryId ?? "",
          date: detail?.date ?? DateTime.now(),
        );

        if (mode.isEditable) {
          emit(ExpenseEditing(
            formData: formData,
            formConfig: formConfig,
          ));
        } else {
          emit(ExpenseLoaded(
            expense: detail,
            formData: formData,
            formConfig: formConfig,
          ));
        }
      },
      onError: (error) => ExpenseError(message: error.message),
      errorEffect: (error) => ShowErrorDialog(
        title: 'Load Failed',
        body: error.message,
      ),
      logContext: {'expenseId': event.id, 'mode': mode.name},
    );
  }

  Future<void> _onFieldChanged(
    FieldChanged event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = _currentFormData;
    if (current == null) return;

    final newData = switch (event.key) {
      'amount' => current.copyWith(amount: event.value as double),
      'title' => current.copyWith(title: event.value as String),
      'categoryId' => current.copyWith(categoryId: event.value as String),
      'date' => current.copyWith(date: event.value as DateTime),
      'paymentMethod' => current.copyWith(paymentMethod: event.value as String),
      'note' => current.copyWith(note: event.value as String),
      _ => current,
    };

    emit(ExpenseEditing(
      formData: newData,
      formConfig: formConfig,
      validationErrors: const {}, // In real world, maybe validate here
    ));
  }

  Future<void> _onSubmit(
    SubmitExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    final current = _currentFormData;
    if (current == null) return;

    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: ExpenseSaving(formData: current, formConfig: formConfig),
      action: () async {
        final input = ExpenseInput(
          id: current.id,
          title: current.title,
          amount: current.amount,
          categoryId: current.categoryId,
          date: current.date ?? DateTime.now(),
          note: current.note,
          paymentMethod: current.paymentMethod,
          createdAt: DateTime.now(),
        );
        final saved = await submitStrategy.execute(input);
        emit(ExpenseSaved(saved: saved));
        _effectController
            .add(const ShowSuccessToast(message: 'Expense saved.'));
        _effectController.add(const NavigateBack());
      },
      onError: (error) => ExpenseError(message: error.message),
      errorEffect: (error) => ShowErrorDialog(
        title: "Save Failed",
        body: error.message,
      ),
    );
  }

  Future<void> _onDeleteRequested(
    DeleteExpenseRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    _effectController.add(ShowDeleteConfirmation(expenseId: event.id));
  }

  Future<void> _onConfirmDelete(
    ConfirmDeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await runner.run(
      stateEmitter: emit,
      effectEmitter: _effectController.add,
      loadingState: const ExpenseLoading(),
      action: () async {
        await deleteExpense.call(event.id);
        _effectController
            .add(const ShowSuccessToast(message: 'Expense deleted.'));
        _effectController.add(const NavigateBack());
      },
      onError: (error) => ExpenseError(message: error.message),
      errorEffect: (error) => ShowErrorDialog(
        title: 'Delete Failed',
        body: error.message,
      ),
      logContext: {'expenseId': event.id},
    );
  }

  Future<void> _onEditTapped(
    EditTapped event,
    Emitter<ExpenseState> emit,
  ) async {
    final id = _currentFormData?.id;
    if (id == null) return;
    _effectController.add(NavigateToEdit(expenseId: id));
  }

  Future<void> _onDiscardChanges(
    DiscardChanges event,
    Emitter<ExpenseState> emit,
  ) async {
    if (_originalDetail == null) {
      _effectController.add(const NavigateBack());
      return;
    }

    // todo: create func convert ExpenseDetail to ExpenseFormData
    final formData = ExpenseFormData(
      id: _originalDetail!.id,
      title: _originalDetail!.title,
      amount: _originalDetail!.amount,
      categoryId: _originalDetail!.categoryId,
      date: _originalDetail!.date,
    );
    emit(ExpenseLoaded(
      expense: _originalDetail,
      formData: formData,
      formConfig: formConfig,
    ));
  }

  ExpenseFormData? get _currentFormData => switch (state) {
        ExpenseEditing(:final formData) => formData,
        ExpenseLoaded(:final formData) => formData,
        ExpenseSaving(:final formData) => formData,
        _ => null,
      };

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }
}
