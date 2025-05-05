import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drkerapp/models/blog_item.dart';

class BlogService {
  static Future<List<BlogItem>> searchBlog(String query) async {
    final url = Uri.parse(
      'https://public-api.wordpress.com/wp/v2/sites/drkerministry.home.blog/posts?search=$query',
    );

    final response = await http.get(url);

    print('Blog API URL: $url');
    print('Response Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map<BlogItem>((item) {
        return BlogItem(
          title: item['title']['rendered'],
          link: item['link'],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch blog posts');
    }
  }
}

