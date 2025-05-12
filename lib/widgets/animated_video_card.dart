import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drkerapp/models/video_item.dart';
import 'video_card.dart';

class AnimatedVideoCard extends StatefulWidget {
  final VideoItem video;

  const AnimatedVideoCard({super.key, required this.video});

  @override
  State<AnimatedVideoCard> createState() => _AnimatedVideoCardState();
}

class _AnimatedVideoCardState extends State<AnimatedVideoCard> {
  double _scale = 1.0;

  void _launchVideo() async {
    final uri = Uri.parse('https://www.youtube.com/watch?v=${widget.video.videoId}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่สามารถเปิดวิดีโอได้')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: _launchVideo,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: VideoCard(
          title: widget.video.title,
          imageUrl: widget.video.thumbnailUrl,
        ),
      ),
    );
  }
}
