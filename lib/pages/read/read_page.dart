import 'package:flutter/material.dart';
import 'blog_list_section.dart'; // Make sure to import this

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ศึกษาพระวจนะของพระเจ้า',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006FFD),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            BlogListSection(
              sectionTitle: '3 ข้อล้ำลึกพระคัมภีร์',
              categoryId: 123, // replace with real ID
            ),
            BlogListSection(
              sectionTitle: 'สรุปพระคัมภีร์เดิม',
              categoryId: 456,
            ),
            BlogListSection(
              sectionTitle: 'สรุปพระคัมภีร์ใหม่',
              categoryId: 789,
            ),
          ],
        ),
      ),
    );
  }
}

