import 'package:flutter/material.dart';
import 'package:drkerapp/pages/explore_page.dart'; // Use the new HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DrKer Ministry',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(), // <-- Set HomePage as the starting page
    );
  }
}