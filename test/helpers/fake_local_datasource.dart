import 'package:expense_tracker/modules/expense/data/datasources/expense_local_ds.dart';
import 'package:expense_tracker/modules/expense/data/models/expense_model.dart';

class FakeLocalExpenseDataSource implements ExpenseLocalDataSource {
  final Map<int, ExpenseModel> _store = {};
  int _autoInc = 1;

  @override
  Future<int> addExpense(ExpenseModel expense) async {
    final id = _autoInc++;
    final model = ExpenseModel(
      id: id,
      title: expense.title,
      amount: expense.amount,
      category: expense.category,
      date: expense.date,
      description: expense.description,
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
    );
    _store[id] = model;
    return id;
  }

  @override
  Future<int> deleteExpense(int id) async {
    return _store.remove(id) != null ? 1 : 0;
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    final list = _store.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  @override
  Future<int> updateExpense(ExpenseModel expense) async {
    final id = expense.id;
    if (id == null || !_store.containsKey(id)) return 0;
    final updated = ExpenseModel(
      id: id,
      title: expense.title,
      amount: expense.amount,
      category: expense.category,
      date: expense.date,
      description: expense.description,
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
    );
    _store[id] = updated;
    return 1;
  }
}
