import 'package:flutter/material.dart';
import 'package:drkerapp/utility/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<VideoItem> searchResults = [];
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();

  Future<void> _searchContent(String query) async {
    setState(() => isLoading = true);
    final blogResults = await BlogService.searchBlog(query);
    final youTubeResults1 = await YouTubeService.searchYouTube(query, AppConstants.drKerYouTubeChannelId);
    final youTubeResults2 = await YouTubeService.searchYouTube(query, AppConstants.drKerLibraryChannelId);

    setState(() {
      searchResults = [...blogResults, ...youTubeResults1, ...youTubeResults2];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ค้นหา', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF006FFD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'ค้นหาคอนเทนต์...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchContent(_controller.text),
                ),
                filled: true,
                fillColor: const Color(0xFFF7F8FD),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final item = searchResults[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.network(item.thumbnailUrl, width: 100, fit: BoxFit.cover),
                      title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoItem {
  final String title;
  final String thumbnailUrl;
  final String? videoId; // optional for blog items

  VideoItem({required this.title, required this.thumbnailUrl, this.videoId});
}

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

class BlogService {
  static Future<List<VideoItem>> searchBlog(String query) async {
    // Replace this with your actual blog search logic
    // Returning dummy data for demo purposes
    await Future.delayed(const Duration(seconds: 1));
    return [
      VideoItem(
        title: 'ผลการค้นหาบล็อก: $query',
        thumbnailUrl: 'https://via.placeholder.com/150x100',
      ),
    ];
  }
}
