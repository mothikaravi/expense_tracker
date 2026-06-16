import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../../presentation/bloc/expense_bloc.dart';
import '../../presentation/bloc/expense_event.dart';
import 'main_screen.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() =>
      _AddExpenseScreenState();
}

class _AddExpenseScreenState
    extends State<AddExpenseScreen> {

  final merchantController =
  TextEditingController();

  final amountController =
  TextEditingController();

  final List<String> categories = [
    'Food',
    'Shopping',
    'Travel',
    'Utilities',
    'Entertainment',
    'Others',
  ];

  String? selectedCategory;

  @override
  void dispose() {
    merchantController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void saveExpense() {
    if (merchantController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all fields',
          ),
        ),
      );
      return;
    }

    final amount = double.tryParse(
      amountController.text.trim(),
    );

    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Enter a valid amount',
          ),
        ),
      );
      return;
    }

    final expense = Expense(
      merchant: merchantController.text.trim(),
      amount: amount,
      category: selectedCategory!,
      date: DateTime.now().toIso8601String(),
      notes: '',
    );

    context.read<ExpenseBloc>().add(
      AddExpense(expense),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Expense Added Successfully',
        ),
      ),
    );

    merchantController.clear();
    amountController.clear();

    setState(() {
      selectedCategory = null;
    });

    MainScreen.tabIndex.value = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Expense',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: merchantController,
                decoration: const InputDecoration(
                  labelText: 'Merchant',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                hint: const Text(
                  'Choose Category',
                ),
                items: categories
                    .map(
                      (category) =>
                      DropdownMenuItem(
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
                  onPressed: saveExpense,
                  child: const Text(
                    'Save Expense',
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