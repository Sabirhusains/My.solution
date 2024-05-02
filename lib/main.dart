import 'package:My.solution/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:My.solution/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependecies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My.solution',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const SpalshScreen(),
    );
  }
}
