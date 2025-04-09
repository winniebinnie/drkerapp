import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/media_screen.dart';
import 'screens/blog_screen.dart';

void main() {
  runApp(DrKerMinistryApp());
}

class DrKerMinistryApp extends StatelessWidget {
  const DrKerMinistryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DrKer Ministry',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    MediaScreen(),
    BlogScreen(),
  ];

  final List<String> _titles = [
    "Home",
    "Media",
    "Blog",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: "Media"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Blog"),
        ],
      ),
    );
  }
}
