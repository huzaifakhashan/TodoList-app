import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/home_page.dart';
import 'package:to_do_list/providers/task_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final provider = TaskProviders();
  await provider.loadTasks();

  runApp(
    ChangeNotifierProvider(
      create: (_) => provider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProviders>(
      builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          title: "قائمتي",
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
