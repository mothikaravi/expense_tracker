import '../../data/models/expense_model.dart';

class ExpenseState {
  final List<Expense> expenses;
  final String insights;
  final bool isLoading;
  final Expense? scannedExpense;
  final String? error;

  const ExpenseState({
    this.expenses = const [],
    this.insights = '',
    this.isLoading = false,
    this.scannedExpense,
    this.error,
  });

  ExpenseState copyWith({
    List<Expense>? expenses,
    String? insights,
    bool? isLoading,
    Expense? scannedExpense,
    String? error,
  }) {
    return ExpenseState(
      expenses: expenses ?? this.expenses,
      insights: insights ?? this.insights,
      isLoading: isLoading ?? this.isLoading,
      scannedExpense: scannedExpense,
      error: error,
    );
  }
}