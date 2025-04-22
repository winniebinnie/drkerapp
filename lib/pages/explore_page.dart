// lib/pages/explore_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:drkerapp/utility/constants.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              _buildVideoCard(title: video.title, imageUrl: video.thumbnailUrl)).toList();
          return _buildHorizontalCardList(title: 'DrKerYouTube', cards: cards);
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
              _buildVideoCard(title: video.title, imageUrl: video.thumbnailUrl)).toList();
          return _buildHorizontalCardList(title: 'DrKerLibrary', cards: cards);
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
              .map((blog) => _buildVideoCard(title: blog.title, imageUrl: blog.thumbnailUrl))
              .toList();
          return _buildHorizontalCardList(title: 'Latest Blog Posts', cards: cards);
        }
      },
    );
  }

  Widget _buildHorizontalCardList({required String title, required List<Widget> cards}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                const Text(
                  'See more',
                  style: TextStyle(color: Color(0xFF006FFD), fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => cards[index],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard({required String title, required String imageUrl}) {
    return Container(
      width: 213,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2024),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// YouTube API Service
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
    // Placeholder, implement WordPress blog fetching logic here
    return Future.delayed(const Duration(seconds: 1), () => []);
  }
}
