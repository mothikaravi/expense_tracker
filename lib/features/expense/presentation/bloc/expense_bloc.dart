import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../../data/repositories/expense_repository.dart';
import '../../../../core/services/gemini_service.dart';

import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository repository = ExpenseRepository();
  final GeminiService geminiService;

  ExpenseBloc(this.geminiService) : super(const ExpenseState()) {
    // ---------------- LOAD ----------------
    on<LoadExpenses>((event, emit) async {
      final data = await repository.getExpenses();
      emit(state.copyWith(expenses: data));
    });

    // ---------------- ADD ----------------
    on<AddExpense>((event, emit) async {
      await repository.insertExpense(event.expense);

      final data = await repository.getExpenses();
      emit(state.copyWith(expenses: data));
    });
    // ---------------- UPDATE/EDIT  ----------------
    on<UpdateExpense>((event, emit) async {
      await repository.updateExpense(event.expense);

      final data = await repository.getExpenses();

      emit(state.copyWith(expenses: data));
    });
    // ---------------- DELETE ----------------
    on<DeleteExpense>((event, emit) async {
      await repository.deleteExpense(event.id);

      final data = await repository.getExpenses();
      emit(state.copyWith(expenses: data));
    });

    // ---------------- INSIGHTS ----------------
    on<GenerateInsights>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));

        final result = await geminiService.generateInsights(
          state.expenses.map((e) => e.toMap()).toList(),
        );

        emit(state.copyWith(insights: result, isLoading: false));
      } catch (e) {
        emit(
          state.copyWith(
            insights: "Failed to generate insights.",
            isLoading: false,
          ),
        );
      }
    });
    // ---------------- SCAN RECEIPT ----------------

    on<ScanReceiptEvent>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));

        final result = await geminiService.scanReceipt(File(event.imagePath));

        final amountText = result['amount']?.toString() ?? '0';

        final cleanedAmount = amountText.replaceAll(RegExp(r'[^0-9.]'), '');

        final expense = Expense(
          merchant: result['merchant'] ?? '',
          amount: double.tryParse(cleanedAmount) ?? 0,
          category: result['category'] ?? 'Others',
          date: result['date'] ?? DateTime.now().toIso8601String(),
          notes: '',
        );

        emit(state.copyWith(scannedExpense: expense, isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });

    on<ClearScannedExpense>((event, emit) {
      emit(
        state.copyWith(
          scannedExpense: null,
        ),
      );
    });
  }
}
