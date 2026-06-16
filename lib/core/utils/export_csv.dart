import 'package:csv/csv.dart';
import '../../features/expense/data/models/expense_model.dart';

class ExportCSV {
  static String generate(List<Expense> expenses) {
    List<List<dynamic>> rows = [];

    rows.add(["Merchant", "Amount", "Category", "Date"]);

    for (var e in expenses) {
      rows.add([
        e.merchant,
        e.amount,
        e.category,
        e.date,
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }
}