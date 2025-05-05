enum SearchResultType { video, blog }

class SearchResultItem {
  final String title;
  final String? thumbnailUrl; // <- Nullable
  final SearchResultType type;
  final String? blogLink;
  final String? videoId;

  SearchResultItem({
    required this.title,
    this.thumbnailUrl, // <- Now optional
    required this.type,
    this.blogLink,
    this.videoId,
  });
}

