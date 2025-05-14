import 'package:flutter/material.dart';
import 'package:drkerapp/models/blog_item.dart';
import 'package:drkerapp/services/blog_service.dart';
import 'package:drkerapp/pages/read/blog_detail_page.dart';

class BlogListSection extends StatelessWidget {
  final String sectionTitle;
  final int categoryId;

  const BlogListSection({
    super.key,
    required this.sectionTitle,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogItem>>(
      future: BlogService.fetchPostsByCategory(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Error loading "$sectionTitle".'),
          );
        }

        final articles = snapshot.data ?? [];
        if (articles.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text('No articles found for "$sectionTitle".'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                sectionTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2024),
                ),
              ),
            ),

            // List of articles (top 3)
            Column(
              children: articles.take(3).map((article) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlogDetailPage(post: article),
                      ),
                    );
                  },
                  child: Container(
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
                      article.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2024),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
