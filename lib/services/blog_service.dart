import 'package:drkerapp/models/blog_item.dart';

class BlogService {
  static Future<List<BlogItem>> fetchLatestPosts() async {
    // Simulating network call, replace this with real API fetching later
    return Future.delayed(const Duration(seconds: 1), () => []);
  }
}
