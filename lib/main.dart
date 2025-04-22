import 'package:flutter/material.dart';
import 'package:drkerapp/pages/explore_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DrKer Ministry',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FD), // matches your ExplorePage card background
      ),
      home: const Scaffold(
        body: SafeArea(
          child: ExplorePage(),
        ),
      ),
    );
  }
}
