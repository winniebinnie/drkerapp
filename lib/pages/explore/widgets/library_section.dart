import 'package:flutter/material.dart';
import 'package:drkerapp/models/video_item.dart';
import 'package:drkerapp/services/youtube_service.dart';
import 'package:drkerapp/utility/constants.dart';
import 'package:drkerapp/widgets/horizontal_card_list.dart';
import 'package:drkerapp/widgets/animated_video_card.dart';
import 'package:drkerapp/pages/explore/see_more_videos_page.dart'; // Make sure to import the SeeMoreVideosPage

class LibrarySection extends StatelessWidget {
  const LibrarySection({super.key});

  @override
  Widget build(BuildContext context) {
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
          final cards = snapshot.data!
              .map((video) => AnimatedVideoCard(video: video))
              .toList();

          return HorizontalCardList(
            title: 'DrKerLibrary',
            cards: cards,
            onSeeMore: () {
              // When See more is clicked, navigate to the SeeMoreVideosPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SeeMoreVideosPage(
                    channelId: AppConstants.drKerLibraryChannelId,
                    title: 'DrKerLibrary',
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
