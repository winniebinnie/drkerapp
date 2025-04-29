import 'package:flutter/material.dart';
import 'package:drkerapp/models/blog_item.dart';
import 'package:drkerapp/services/blog_service.dart';
import 'package:drkerapp/widgets/video_card.dart';
import 'package:drkerapp/widgets/horizontal_card_list.dart';

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
