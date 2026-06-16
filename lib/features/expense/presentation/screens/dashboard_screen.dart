import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';
import 'edit_expense_screen.dart';
import 'gemini_insights_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  double _total(List expenses) {
    return expenses.fold(0, (sum, e) => sum + e.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense AI"),
        actions: [
          Row(
            children: [
              IconButton(
              icon: const Icon(Icons.insights),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InsightsScreen(),
                  ),
                );
              },
            ),
              IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              ),
            ],
          )
        ],
      ),

      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          final total = _total(state.expenses);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                // SUMMARY
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _box("Total", "₹${total.toStringAsFixed(0)}"),
                      _box("Count", "${state.expenses.length}"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // PIE CHART
                SizedBox(
                  height: 220,
                  child: PieChart(
                    PieChartData(
                      sections: state.expenses.map((e) {
                        return PieChartSectionData(
                          value: e.amount,
                          title: e.category,
                          radius: 60,
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // LIST
                const Text(
                  "Recent Transactions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                if (state.expenses.isEmpty)
                  const Text("No data yet")
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.expenses.length,
                    itemBuilder: (context, i) {
                      final e = state.expenses[i];

                      return Card(
                        child: ListTile(
                          title: Text(e.merchant),
                          subtitle: Text(e.category),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("₹${e.amount}"),

                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EditExpenseScreen(
                                        expense: e,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context
                                      .read<ExpenseBloc>()
                                      .add(DeleteExpense(e.id!));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _box(String t, String v) {
    return Column(
      children: [
        Text(t, style: const TextStyle(color: Colors.white70)),
        Text(v,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}