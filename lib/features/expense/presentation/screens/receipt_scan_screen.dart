import 'dart:io';

import 'package:expense_tracker/features/expense/presentation/screens/review_scanned_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';

class ReceiptScanScreen extends StatefulWidget {
  const ReceiptScanScreen({super.key});

  @override
  State<ReceiptScanScreen> createState() => _ReceiptScanScreenState();
}

class _ReceiptScanScreenState extends State<ReceiptScanScreen> {
  File? image;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receipt Scanner"),
      ),
      body: BlocConsumer<ExpenseBloc, ExpenseState>(
        listener: (context, state) {

          if (state.scannedExpense != null) {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReviewScannedExpenseScreen(
                  expense: state.scannedExpense!,
                ),
              ),
            );
          }

          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      image!,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: pickImage,
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Pick Receipt Image"),
                ),

                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: image == null
                      ? null
                      : () {
                    context.read<ExpenseBloc>().add(
                      ScanReceiptEvent(image!.path),
                    );
                  },
                  icon: const Icon(Icons.document_scanner),
                  label: const Text("Scan Receipt"),
                ),

                const SizedBox(height: 20),

                if (state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),

                const SizedBox(height: 20),

                Text(
                  "Saved Expenses",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: state.expenses.isEmpty
                      ? const Center(
                    child: Text(
                      "No expenses found",
                    ),
                  )
                      : ListView.builder(
                    itemCount: state.expenses.length,
                    itemBuilder: (context, index) {
                      final expense = state.expenses[index];

                      return Card(
                        elevation: 2,
                        margin:
                        const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.receipt_long),
                          ),
                          title: Text(expense.merchant),
                          subtitle: Text(
                            "${expense.category}\n${expense.date}",
                          ),
                          trailing: Text(
                            "₹${expense.amount}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}