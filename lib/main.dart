import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/services/gemini_service.dart';
import 'core/theme/theme_cubit.dart';
import 'features/expense/presentation/bloc/expense_bloc.dart';
import 'features/expense/presentation/bloc/expense_event.dart';
import 'features/expense/presentation/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          ExpenseBloc(GeminiService())
            ..add(LoadExpenses()),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,

          home: const MainScreen(),
        );
      },
    );
  }
}
