import 'package:flutter/material.dart';

class PlaceholderBlogPage extends StatelessWidget {
  const PlaceholderBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blog')),
      body: const Center(
        child: Text('This is a placeholder for the full blog view.'),
      ),
    );
  }
}
