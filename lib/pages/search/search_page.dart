import 'package:flutter/material.dart';
import 'package:drkerapp/utility/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drkerapp/services/youtube_service.dart';
import 'package:drkerapp/models/search_result_item.dart';
import 'package:drkerapp/services/blog_service.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DrKerSearchDelegate());
            },
          ),
        ],
      ),
      body: const Center(child: Text('Search content here...')),
    );
  }
}

class DrKerSearchDelegate extends SearchDelegate<String> {
  List<SearchResultItem> searchResults = [];
  bool isLoading = false;

  Future<List<SearchResultItem>> _searchContent(String query) async {
    final blogItems = await BlogService.searchBlog(query);
    final youTubeResults1 = await YouTubeService.searchYouTube(query, AppConstants.drKerYouTubeChannelId);
    final youTubeResults2 = await YouTubeService.searchYouTube(query, AppConstants.drKerLibraryChannelId);

    return [
      ...blogItems.map((b) => SearchResultItem(
        title: b.title,
        type: SearchResultType.blog,
        blogLink: b.link,
      )),
      ...youTubeResults1.map((v) => SearchResultItem(
        title: v.title,
        thumbnailUrl: v.thumbnailUrl,
        type: SearchResultType.video,
        videoId: v.videoId,
      )),
      ...youTubeResults2.map((v) => SearchResultItem(
        title: v.title,
        thumbnailUrl: v.thumbnailUrl,
        type: SearchResultType.video,
        videoId: v.videoId,
      )),
    ];
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
    return FutureBuilder<List<SearchResultItem>>(
      future: _searchContent(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
        }
        final results = snapshot.data ?? [];

        if (results.isEmpty) {
          return const Center(child: Text('ไม่พบผลลัพธ์'));
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                  leading: item.thumbnailUrl != null
                      ? Image.network(item.thumbnailUrl!, width: 100, fit: BoxFit.cover)
                      : null,
                title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () async {
                  final uri = item.type == SearchResultType.video
                      ? Uri.parse('https://www.youtube.com/watch?v=${item.videoId}')
                      : Uri.parse(item.blogLink!);

                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.platformDefault);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ไม่สามารถเปิดลิงก์ได้')),
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