import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';

class ReviewScannedExpenseScreen extends StatefulWidget {
  final Expense expense;

  const ReviewScannedExpenseScreen({
    super.key,
    required this.expense,
  });

  @override
  State<ReviewScannedExpenseScreen> createState() =>
      _ReviewScannedExpenseScreenState();
}

class _ReviewScannedExpenseScreenState
    extends State<ReviewScannedExpenseScreen> {

  late TextEditingController merchantController;
  late TextEditingController amountController;
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();

    merchantController =
        TextEditingController(
          text: widget.expense.merchant,
        );

    amountController =
        TextEditingController(
          text: widget.expense.amount.toString(),
        );

    categoryController =
        TextEditingController(
          text: widget.expense.category,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Receipt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: merchantController,
              decoration: const InputDecoration(
                labelText: "Merchant",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {

                final expense = Expense(
                  merchant: merchantController.text.trim(),
                  amount: double.tryParse(
                    amountController.text.trim(),
                  ) ??
                      0,
                  category: categoryController.text.trim(),
                  date: widget.expense.date,
                  notes: '',
                );

                context.read<ExpenseBloc>().add(
                  AddExpense(expense),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Expense saved successfully",
                    ),
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text(
                "Save Expense",
              ),
            ),
          ],
        ),
      ),
    );
  }
}