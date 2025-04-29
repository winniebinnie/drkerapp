import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:drkerapp/utility/constants.dart';
import 'package:drkerapp/widgets/video_card.dart';
import 'package:drkerapp/widgets/horizontal_card_list.dart';


class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBlogSection(),
                    _buildYouTubeSection(),
                    _buildLibrarySection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
              height: 40,
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ค้นหา...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => print("Menu icon tapped"),
          ),
        ],
      ),
    );
  }

  Widget _buildYouTubeSection() {
    return FutureBuilder<List<VideoItem>>(
      future: YouTubeService.fetchLatestVideos(AppConstants.drKerYouTubeChannelId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final cards = snapshot.data!.map((video) =>
              VideoCard(title: video.title, imageUrl: video.thumbnailUrl)).toList();
          return HorizontalCardList(title: 'DrKerYouTube', cards: cards);
        }
      },
    );
  }

  Widget _buildLibrarySection() {
    return FutureBuilder<List<VideoItem>>(
      future: YouTubeService.fetchLatestVideos(AppConstants.drKerLibraryChannelId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final cards = snapshot.data!.map((video) =>
              VideoCard(title: video.title, imageUrl: video.thumbnailUrl)).toList();
          return HorizontalCardList(title: 'DrKerLibrary', cards: cards);
        }
      },
    );
  }

  Widget _buildBlogSection() {
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

class YouTubeService {
  static Future<List<VideoItem>> fetchLatestVideos(String channelId) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search?key=${AppConstants.youtubeApiKey}&channelId=$channelId&part=snippet,id&order=date&maxResults=5',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List items = json['items'];

      return items
          .where((item) => item['id']['kind'] == 'youtube#video')
          .map<VideoItem>((item) => VideoItem(
        title: item['snippet']['title'],
        thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
        videoId: item['id']['videoId'],
      ))
          .toList();
    } else {
      throw Exception('Failed to load videos: ${response.body}');
    }
  }
}

class VideoItem {
  final String title;
  final String thumbnailUrl;
  final String videoId;

  VideoItem({required this.title, required this.thumbnailUrl, required this.videoId});
}

class BlogItem {
  final String title;
  final String thumbnailUrl;

  BlogItem({required this.title, required this.thumbnailUrl});
}

class BlogService {
  static Future<List<BlogItem>> fetchLatestPosts() async {
    return Future.delayed(const Duration(seconds: 1), () => []);
  }
}
