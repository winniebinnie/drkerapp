import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  final String title;
  final List<Widget> cards;
  final VoidCallback? onSeeMore;

  const HorizontalCardList({
    required this.title,
    required this.cards,
    this.onSeeMore,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2024),
                  ),
                ),
                GestureDetector(
                  onTap: onSeeMore,
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      color: Color(0xFF006FFD),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => cards[index],
            ),
          ),
        ],
      ),
    );
  }
}
