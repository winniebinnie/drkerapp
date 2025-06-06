import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drkerapp/pages/explore/explore_page.dart';
import 'package:drkerapp/pages/read/read_page.dart';

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
        fontFamily: GoogleFonts.notoSansThai().fontFamily,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FD),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: 14,
            color: const Color(0xFF1F2024),
            fontFamily: GoogleFonts.notoSansThai().fontFamily,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.notoSansThai().fontFamily,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ExplorePage(),
    ReadPage(),
    Center(child: Text('Profile Page')), // Replace with actual page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF006FFD),
        unselectedItemColor: const Color(0xFF71727A),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Read'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
