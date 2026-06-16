import '../../../../core/database/database_helper.dart';
import '../models/expense_model.dart';

class ExpenseRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertExpense(Expense expense) async {
    final db = await dbHelper.database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<Expense>> getExpenses() async {
    final db = await dbHelper.database;

    final result = await db.query(
      'expenses',
      orderBy: 'id DESC',
    );

    return result.map((e) => Expense.fromMap(e)).toList();
  }

  Future<void> updateExpense(Expense expense) async {
    final db = await DatabaseHelper.instance.database;

    await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await dbHelper.database;

    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}