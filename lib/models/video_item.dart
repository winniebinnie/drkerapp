class VideoItem {
  final String title;
  final String thumbnailUrl;
  final String? videoId;

  VideoItem({
    required this.title,
    required this.thumbnailUrl,
    this.videoId,
  });
}
