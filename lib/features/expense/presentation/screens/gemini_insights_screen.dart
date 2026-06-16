import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseBloc>().add(
        GenerateInsights(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Spending Insights"),
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    "Analyzing your expenses...",
                  ),
                ],
              ),
            );
          }

          if (state.expenses.isEmpty) {
            return const Center(
              child: Text(
                "No expenses available for analysis",
              ),
            );
          }

          if (state.insights.isEmpty) {
            return Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.insights),
                label: const Text("Generate Insights"),
                onPressed: () {
                  context.read<ExpenseBloc>().add(
                    GenerateInsights(),
                  );
                },
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ExpenseBloc>().add(
                GenerateInsights(),
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.auto_awesome),
                          SizedBox(width: 8),
                          Text(
                            "AI Financial Analysis",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 24),

                      Text(
                        state.insights,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label:
                          const Text("Regenerate Insights"),
                          onPressed: () {
                            context.read<ExpenseBloc>().add(
                              GenerateInsights(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}