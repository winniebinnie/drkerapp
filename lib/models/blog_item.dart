class BlogItem {
  final String title;
  final String? thumbnailUrl; // Make it nullable
  final String link;

  BlogItem({
    required this.title,
    this.thumbnailUrl,
    required this.link,
  });
}
