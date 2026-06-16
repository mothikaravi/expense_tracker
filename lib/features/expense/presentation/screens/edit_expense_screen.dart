import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';

class EditExpenseScreen extends StatefulWidget {
  final Expense expense;

  const EditExpenseScreen({
    super.key,
    required this.expense,
  });

  @override
  State<EditExpenseScreen> createState() =>
      _EditExpenseScreenState();
}

class _EditExpenseScreenState
    extends State<EditExpenseScreen> {

  late TextEditingController merchantController;
  late TextEditingController amountController;
  late TextEditingController notesController;

  String? selectedCategory;

  final List<String> categories = [
    'Food',
    'Shopping',
    'Travel',
    'Utilities',
    'Entertainment',
    'Others',
  ];

  @override
  void initState() {
    super.initState();

    merchantController = TextEditingController(
      text: widget.expense.merchant,
    );

    amountController = TextEditingController(
      text: widget.expense.amount.toString(),
    );

    notesController = TextEditingController(
      text: widget.expense.notes ?? '',
    );

    selectedCategory = widget.expense.category;
  }

  @override
  void dispose() {
    merchantController.dispose();
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: merchantController,
                decoration: const InputDecoration(
                  labelText: "Merchant",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                items: categories
                    .map(
                      (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),



              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final updatedExpense = Expense(
                      id: widget.expense.id,
                      merchant: merchantController.text,
                      amount: double.tryParse(
                        amountController.text,
                      ) ??
                          0,
                      category:
                      selectedCategory ?? 'Others',
                      date: widget.expense.date,
                      notes: notesController.text,
                    );

                    context.read<ExpenseBloc>().add(
                      UpdateExpense(updatedExpense),
                    );

                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Update Expense",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}