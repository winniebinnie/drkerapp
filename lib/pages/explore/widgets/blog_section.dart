import 'package:flutter/material.dart';
import 'package:drkerapp/widgets/video_card.dart';
import 'package:drkerapp/widgets/horizontal_card_list.dart';

// Mock BlogItem model (if not already imported)
class BlogItem {
  final String title;
  final String thumbnailUrl;
  final String link;

  BlogItem({
    required this.title,
    required this.thumbnailUrl,
    required this.link,
  });
}

// Temporary mock service
class BlogService {
  static Future<List<BlogItem>> fetchLatestPosts() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      BlogItem(
        title: 'Sample Blog Post 1',
        thumbnailUrl: 'https://via.placeholder.com/150',
        link: 'https://example.com/post1',
      ),
      BlogItem(
        title: 'Sample Blog Post 2',
        thumbnailUrl: 'https://via.placeholder.com/150',
        link: 'https://example.com/post2',
      ),
    ];
  }
}

// EXISITING CODE

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogItem>>(
      future: BlogService.fetchLatestPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Error loading blog posts.'),
          );
        } else if (snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text('Blog feature coming soon...'),
          );
        } else {
          final cards = snapshot.data!
              .map((blog) => VideoCard(title: blog.title, imageUrl: blog.thumbnailUrl))
              .toList();
          return HorizontalCardList(title: 'Latest Blog Posts', cards: cards);
        }
      },
    );
  }
}
