import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/modules/expense/domain/entities/expense.dart';
import 'package:expense_tracker/modules/expense/domain/usecases/add_expense.dart';
import 'package:expense_tracker/modules/expense/domain/usecases/delete_expense.dart';
import 'package:expense_tracker/modules/expense/domain/usecases/get_expenses.dart';
import 'package:expense_tracker/modules/expense/domain/usecases/update_expense.dart';
import 'package:expense_tracker/modules/expense/presentation/blocs/expense_list_bloc/expense_list_bloc.dart';
import 'helpers/fake_repository.dart';

void main() {
  group('ExpenseListBloc', () {
    late ExpenseListBloc bloc;
    late FakeExpenseRepository fakeRepo;

    setUp(() {
      fakeRepo = FakeExpenseRepository();
      bloc = ExpenseListBloc(
        getExpenses: GetExpenses(fakeRepo),
        addExpense: AddExpense(fakeRepo),
        updateExpense: UpdateExpense(fakeRepo),
        deleteExpense: DeleteExpense(fakeRepo),
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is ExpenseListInitial', () {
      expect(bloc.state, isA<ExpenseListInitial>());
    });

    blocTest<ExpenseListBloc, ExpenseListState>(
      'emits [Loading, Empty] when LoadExpenses with no data',
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadExpenses()),
      expect: () => [
        isA<ExpenseListLoading>(),
        isA<ExpenseListEmpty>(),
      ],
    );

    blocTest<ExpenseListBloc, ExpenseListState>(
      'emits [Loading, Loaded] when LoadExpenses with data',
      build: () {
        final now = DateTime.now();
        final e = Expense(
          title: 'Test',
          amount: 10.0,
          category: 'Cat',
          date: now,
          description: null,
          createdAt: now,
        );
        fakeRepo.testExpenses.add(e);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadExpenses()),
      expect: () => [
        isA<ExpenseListLoading>(),
        isA<ExpenseListLoaded>()
            .having((s) => s.expenses.length, 'length', 1)
            .having((s) => s.expenses.first.title, 'title', 'Test'),
      ],
    );

    blocTest<ExpenseListBloc, ExpenseListState>(
      'emits [Loading, Loaded] when AddExpense and reload',
      build: () => bloc,
      act: (bloc) {
        final now = DateTime.now();
        final e = Expense(
          title: 'NewExpense',
          amount: 20.0,
          category: 'X',
          date: now,
          description: null,
          createdAt: now,
        );
        bloc.add(AddExpenseEvent(e));
      },
      expect: () => [
        isA<ExpenseListLoading>(),
        isA<ExpenseListLoaded>()
            .having((s) => s.expenses.length, 'length', 1)
            .having((s) => s.expenses.first.title, 'title', 'NewExpense'),
      ],
    );

    blocTest<ExpenseListBloc, ExpenseListState>(
      'emits [Loading, Loaded] when DeleteExpense and reload',
      build: () {
        final now = DateTime.now();
        final e = Expense(
          id: 1,
          title: 'ToDelete',
          amount: 5.0,
          category: 'Y',
          date: now,
          description: null,
          createdAt: now,
        );
        fakeRepo.testExpenses.add(e);
        return bloc;
      },
      act: (bloc) {
        bloc.add(const DeleteExpenseEvent(1));
      },
      expect: () => [
        isA<ExpenseListLoading>(),
        isA<ExpenseListEmpty>(),
      ],
    );
  });
}
