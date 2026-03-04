import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/modules/expense/domain/entities/expense.dart';
import 'package:expense_tracker/modules/expense/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/modules/expense/domain/usecases/add_expense.dart';
import 'package:expense_tracker/modules/expense/domain/usecases/get_expenses.dart';
import 'package:expense_tracker/modules/expense/domain/usecases/update_expense.dart';
import 'package:expense_tracker/modules/expense/domain/usecases/delete_expense.dart';

// In-memory implementation of ExpenseRepository for tests
class InMemoryExpenseRepository implements ExpenseRepository {
  final Map<int, Expense> _store = {};
  int _autoIncrement = 0;

  @override
  Future<int> addExpense(Expense expense) async {
    _autoIncrement++;
    final e = expense.copyWith(id: _autoIncrement);
    _store[_autoIncrement] = e;
    return _autoIncrement;
  }

  @override
  Future<int> deleteExpense(int id) async {
    return _store.remove(id) != null ? 1 : 0;
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final list = _store.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  @override
  Future<int> updateExpense(Expense expense) async {
    final id = expense.id;
    if (id == null || !_store.containsKey(id)) return 0;
    _store[id] = expense;
    return 1;
  }
}

void main() {
  group('Expense UseCases', () {
    late InMemoryExpenseRepository repository;
    late AddExpense addExpense;
    late GetExpenses getExpenses;
    late UpdateExpense updateExpense;
    late DeleteExpense deleteExpense;

    setUp(() {
      repository = InMemoryExpenseRepository();
      addExpense = AddExpense(repository);
      getExpenses = GetExpenses(repository);
      updateExpense = UpdateExpense(repository);
      deleteExpense = DeleteExpense(repository);
    });

    test('add and get expenses', () async {
      final now = DateTime.now();
      final expense = Expense(
        title: 'Test',
        amount: 10.0,
        category: 'Misc',
        date: now,
        description: 'desc',
        createdAt: now,
      );

      final id = await addExpense(expense);
      expect(id, equals(1));

      final list = await getExpenses();
      expect(list.length, equals(1));
      expect(list.first.title, equals('Test'));
    });

    test('update expense', () async {
      final now = DateTime.now();
      final expense = Expense(
        title: 'Original',
        amount: 20.0,
        category: 'Food',
        date: now,
        description: 'orig',
        createdAt: now,
      );

      final id = await addExpense(expense);
      final toUpdate = expense.copyWith(id: id, title: 'Updated', amount: 25.0);
      final rows = await updateExpense(toUpdate);
      expect(rows, equals(1));

      final list = await getExpenses();
      expect(list.first.title, equals('Updated'));
      expect(list.first.amount, equals(25.0));
    });

    test('delete expense', () async {
      final now = DateTime.now();
      final e1 = Expense(
        title: 'One',
        amount: 5.0,
        category: 'A',
        date: now,
        description: null,
        createdAt: now,
      );
      final e2 = Expense(
        title: 'Two',
        amount: 7.0,
        category: 'B',
        date: now.subtract(const Duration(days: 1)),
        description: null,
        createdAt: now.subtract(const Duration(days: 1)),
      );

      final id1 = await addExpense(e1);
      final id2 = await addExpense(e2);

      var list = await getExpenses();
      expect(list.length, equals(2));

      final rows = await deleteExpense(id1);
      expect(rows, equals(1));

      list = await getExpenses();
      expect(list.length, equals(1));
      expect(list.first.id, equals(id2));
    });
  });
}
