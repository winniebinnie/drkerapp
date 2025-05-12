import 'package:flutter/material.dart';
import 'package:drkerapp/models/video_item.dart';
import 'package:drkerapp/services/youtube_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SeeMoreVideosPage extends StatelessWidget {
  final String channelId;
  final String title;

  const SeeMoreVideosPage({super.key, required this.channelId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<VideoItem>>(
        future: YouTubeService.fetchAllLatestVideos(channelId, maxResults: 20),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No videos found.'));
          }

          final videos = snapshot.data!;

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Image.network(video.thumbnailUrl, width: 100, fit: BoxFit.cover),
                title: Text(video.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () async {
                  final uri = Uri.parse('https://www.youtube.com/watch?v=${video.videoId}');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
