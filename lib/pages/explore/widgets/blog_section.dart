import 'package:drkerapp/models/blog_item.dart';
import 'package:drkerapp/services/blog_service.dart';
import 'package:flutter/material.dart';
import 'package:drkerapp/pages/read/placeholder_blog_page.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';



class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BlogItem>(
      future: BlogService.fetchLatestPost(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Error loading latest blog post.'),
          );
        } else {
          final post = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 150,
                    child: SingleChildScrollView(
                      child: HtmlWidget(post.content),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlaceholderBlogPage(),
                          ),
                        );
                      },
                      child: const Text('Continue Reading'),
                    ),
                  )
                ],
              ),

            ),
          );
        }
      },
    );
  }
}
