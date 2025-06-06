import 'package:flutter/material.dart';
import 'package:drkerapp/models/blog_item.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogItem post;

  const BlogDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: SingleChildScrollView(
        child: HtmlWidget(
          post.content,
          textStyle: TextStyle(fontSize: 18), // Adjust font size here
        ),
      ),
    );
  }
}
