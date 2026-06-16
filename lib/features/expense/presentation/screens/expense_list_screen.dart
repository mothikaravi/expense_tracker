import 'package:flutter/material.dart';

import '../../data/models/expense_model.dart';
import '../../data/repositories/expense_repository.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() =>
      _ExpenseListScreenState();
}

class _ExpenseListScreenState
    extends State<ExpenseListScreen> {

  final repository = ExpenseRepository();

  List<Expense> expenses = [];

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    expenses =
    await repository.getExpenses();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense History',
        ),
      ),
      body: expenses.isEmpty
          ? const Center(
        child: Text(
          'No Expenses Found',
        ),
      )
          : ListView.builder(
        itemCount:
        expenses.length,
        itemBuilder:
            (context, index) {
          final expense =
          expenses[index];

          return ListTile(
            title: Text(
              expense.merchant,
            ),
            subtitle: Text(
              expense.category,
            ),
            trailing: Text(
              '₹${expense.amount}',
            ),
          );
        },
      ),
    );
  }
}