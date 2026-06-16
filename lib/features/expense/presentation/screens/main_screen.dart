import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'add_expense_screen.dart';
import 'expense_list_screen.dart';
import 'receipt_scan_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static final ValueNotifier<int> tabIndex =
  ValueNotifier<int>(0);

  @override
  State<MainScreen> createState() =>
      _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final pages = const [
    DashboardScreen(),
    AddExpenseScreen(),
    ExpenseListScreen(),
    ReceiptScanScreen(),
  ];

  @override
  void initState() {
    super.initState();

    MainScreen.tabIndex.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[MainScreen.tabIndex.value],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: MainScreen.tabIndex.value,

        onTap: (i) {
          MainScreen.tabIndex.value = i;
        },

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: "Scan",
          ),
        ],
      ),
    );
  }
}