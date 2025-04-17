import 'package:flutter/material.dart';

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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('3 ข้อล้ำลึกพระคัมภีร์'),
          _buildListItem('3 ข้อล้ำลึก ใน สุภาษิต 22'),
          _buildListItem('3 ข้อล้ำลึก ใน สุภาษิต 21'),
          _buildListItem('3 ข้อล้ำลึก ใน สุภาษิต 23'),
          const SizedBox(height: 24),

          _buildSectionTitle('สรุปพระคัมภีร์เดิม'),
          _buildListItem('ปฐมกาล'),
          _buildListItem('อพยพ'),
          _buildListItem('เลวีนิติ'),
          _buildListItem('กันดารวิถี'),
          const SizedBox(height: 24),

          _buildSectionTitle('สรุปพระคัมภีร์ใหม่'),
          _buildListItem('มัทธิว'),
          _buildListItem('มาระโก'),
          _buildListItem('ลูกา'),
          _buildListItem('ยอห์น'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1F2024),
        ),
      ),
    );
  }

  Widget _buildListItem(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1F2024),
        ),
      ),
    );
  }
}
