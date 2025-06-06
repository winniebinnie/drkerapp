import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drkerapp/models/blog_item.dart';
import 'package:html_unescape/html_unescape.dart';

class BlogService {
  // Fetch latest blog posts
  static Future<BlogItem> fetchLatestPost() async {
    final url = Uri.parse(
      'https://public-api.wordpress.com/wp/v2/sites/drkerministry.home.blog/posts?per_page=1',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      final item = data.first;
      final unescape = HtmlUnescape();

      return BlogItem(
        title: unescape.convert(item['title']['rendered']),
        link: item['link'],
        content: unescape.convert(item['content']['rendered']),
      );
    } else {
      throw Exception('Failed to fetch latest blog post');
    }
  }

  // Search blog posts by query
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
          content: item['content']['rendered'],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch blog posts');
    }
  }

  // Fetch blog posts by category ID
  static Future<List<BlogItem>> fetchPostsByCategory(int categoryId) async {
    final url = Uri.parse(
      'https://public-api.wordpress.com/wp/v2/sites/drkerministry.home.blog/posts?categories=$categoryId',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map<BlogItem>((item) {
        return BlogItem(
          title: item['title']['rendered'],
          link: item['link'],
          content: item['content']['rendered'],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch posts by category');
    }
  }

}
