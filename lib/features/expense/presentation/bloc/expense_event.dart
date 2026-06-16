import '../../data/models/expense_model.dart';

abstract class ExpenseEvent {}

class LoadExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;
  AddExpense(this.expense);
}

class DeleteExpense extends ExpenseEvent {
  final int id;
  DeleteExpense(this.id);
}

class UpdateExpense extends ExpenseEvent {
  final Expense expense;

  UpdateExpense(this.expense);
}

class GenerateInsights extends ExpenseEvent {}

class ScanReceiptEvent extends ExpenseEvent {
  final String imagePath;
  ScanReceiptEvent(this.imagePath);
}

class ClearScannedExpense extends ExpenseEvent {}