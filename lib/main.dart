import 'package:flutter/material.dart';
import 'package:todo_app/provider/profile_provider.dart';
import 'package:todo_app/ui/home.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/data/repositories/profile_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoRepository.init();
  await ProfileRepository.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoProvider>(
          create: (_) => TodoProvider(repository: TodoRepository()),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(repository: ProfileRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5038BC)),
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const HomePage(),
    );
  }
}
