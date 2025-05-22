import 'package:drkerapp/models/blog_item.dart';
import 'package:drkerapp/services/blog_service.dart';
import 'package:flutter/material.dart';
import 'package:drkerapp/pages/read/blog_detail_page.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
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
                  // Title with consistent side padding
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: 0,
                    ),
                    child: Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Content: full-width, top padding, internal padding for colored containers
                  SizedBox(
                    height: 150,
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        post.content,
                        customWidgetBuilder: (element) {
                          final hasBackground = element.attributes['style']?.contains('background') ?? false;
                          if ((element.localName == 'div' || element.localName == 'section') && hasBackground) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: HtmlWidget(element.innerHtml),
                            );
                          }
                          return null;
                        },
                      )

                    ),
                  ),
                  const SizedBox(height: 12),

                  // Button to continue reading
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, bottom: 3),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDetailPage(post: post),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward, size: 18, color: Color(0xFF006FFD)),
                        label: const Text(
                          'อ่านต่อ',
                          style: TextStyle(
                            color: Color(0xFF006FFD),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          );
        }
      },
    );
  }
}
