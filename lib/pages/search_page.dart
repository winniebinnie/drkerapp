import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:drkerapp/utility/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DrKerSearchDelegate());
            },
          ),
        ],
      ),
      body: const Center(child: Text('Explore content here...')),
    );
  }
}

// The SearchDelegate class
class DrKerSearchDelegate extends SearchDelegate<String> {
  List<VideoItem> searchResults = [];
  bool isLoading = false;

  Future<void> _searchContent(String query) async {
    isLoading = true;
    final blogResults = await BlogService.searchBlog(query);
    final youTubeResults1 = await YouTubeService.searchYouTube(query, AppConstants.drKerYouTubeChannelId);
    final youTubeResults2 = await YouTubeService.searchYouTube(query, AppConstants.drKerLibraryChannelId);
    searchResults = [...blogResults, ...youTubeResults1, ...youTubeResults2];
    isLoading = false;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _searchContent(query),
      builder: (context, snapshot) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (searchResults.isEmpty) {
          return const Center(child: Text('ไม่พบผลลัพธ์'));
        }
        return ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final item = searchResults[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Image.network(item.thumbnailUrl, width: 100, fit: BoxFit.cover),
                title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () async {
                  if (item.videoId != null) {
                    final url = 'https://www.youtube.com/watch?v=${item.videoId}';
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.platformDefault);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open YouTube')),
                      );
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailPage(title: item.title),
                      ),
                    );
                  }
                },

              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('เริ่มพิมพ์เพื่อค้นหา...'));
  }
}

// Data model
class VideoItem {
  final String title;
  final String thumbnailUrl;
  final String? videoId;

  VideoItem({required this.title, required this.thumbnailUrl, this.videoId});
}

// YouTube service
class YouTubeService {
  static Future<List<VideoItem>> searchYouTube(String query, String channelId) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search?key=${AppConstants.youtubeApiKey}&channelId=$channelId&q=$query&part=snippet&type=video&maxResults=10',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List items = jsonDecode(response.body)['items'];
      return items.map((item) => VideoItem(
        title: item['snippet']['title'],
        thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
        videoId: item['id']['videoId'],
      )).toList();
    } else {
      throw Exception('Failed to search YouTube');
    }
  }
}

// Blog service (mocked)
class BlogService {
  static Future<List<VideoItem>> searchBlog(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      VideoItem(
        title: 'ผลการค้นหาบล็อก: $query',
        thumbnailUrl: 'https://via.placeholder.com/150x100',
      ),
    ];
  }
}

// Simple blog details placeholder
class BlogDetailPage extends StatelessWidget {
  final String title;

  const BlogDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blog Detail')),
      body: Center(child: Text('Showing blog post: $title')),
    );
  }
}
