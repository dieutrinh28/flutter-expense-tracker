import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/modules/expense/data/repositories/expense_repository_impl.dart';
import 'package:expense_tracker/modules/expense/domain/entities/expense.dart';
import 'helpers/fake_local_datasource.dart';

void main() {
  group('ExpenseRepositoryImpl CRUD', () {
    late ExpenseRepositoryImpl repository;
    late FakeLocalExpenseDataSource fakeLocal;

    setUp(() {
      fakeLocal = FakeLocalExpenseDataSource();
      repository = ExpenseRepositoryImpl(local: fakeLocal);
    });

    test('add and get expenses', () async {
      final now = DateTime.now();
      final e = Expense(
        title: 'Test',
        amount: 10.0,
        category: 'Misc',
        date: now,
        description: 'desc',
        createdAt: now,
      );

      final id = await repository.addExpense(e);
      expect(id, isNonZero);

      final list = await repository.getExpenses();
      expect(list.length, 1);
      expect(list.first.title, 'Test');
    });

    test('update expense', () async {
      final now = DateTime.now();
      final e = Expense(
        title: 'ToUpdate',
        amount: 20.0,
        category: 'Cat',
        date: now,
        description: null,
        createdAt: now,
      );
      final id = await repository.addExpense(e);
      final inserted = (await repository.getExpenses()).first;

      final updated = inserted.copyWith(title: 'Updated', amount: 25.0);
      final rows = await repository.updateExpense(updated);
      expect(rows, 1);

      final list = await repository.getExpenses();
      expect(list.first.title, 'Updated');
      expect(list.first.amount, 25.0);
    });

    test('delete expense', () async {
      final now = DateTime.now();
      final e = Expense(
        title: 'ToDelete',
        amount: 5.0,
        category: 'X',
        date: now,
        description: null,
        createdAt: now,
      );
      final id = await repository.addExpense(e);
      final inserted = (await repository.getExpenses()).first;

      final rows = await repository.deleteExpense(inserted.id!);
      expect(rows, 1);

      final list = await repository.getExpenses();
      expect(list, isEmpty);
    });
  });
}
