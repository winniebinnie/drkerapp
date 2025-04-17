import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ค้นหา',
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
          _buildSearchBar(),
          const SizedBox(height: 16),
          _buildResultCard(title: 'Amazing Shoes', price: '€ 12.00'),
          _buildResultCard(title: 'Fabulous Shoes', price: '€ 15.00'),
          _buildResultCard(title: 'Fantastic Shoes', price: '€ 15.00'),
          _buildResultCard(title: 'Spectacular Shoes', price: '€ 12.00'),
          _buildResultCard(title: 'Stunning Shoes', price: '€ 12.00'),
          _buildResultCard(title: 'Wonderful Shoes', price: '€ 15.00'),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FD),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: const [
          Icon(Icons.search, color: Color(0xFF2E3036), size: 16),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Shoes',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1F2024),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard({required String title, required String price}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 32, color: Color(0xFFB3DAFF)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1F2024),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2024),
            ),
          ),
        ],
      ),
    );
  }
}