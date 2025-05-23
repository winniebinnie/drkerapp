import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:drkerapp/utility/constants.dart';
import 'package:drkerapp/models/video_item.dart';

class YouTubeService {
  static Future<List<VideoItem>> fetchLatestVideos(String channelId) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search'
          '?key=${AppConstants.youtubeApiKey}'
          '&channelId=$channelId'
          '&part=snippet,id'
          '&order=date'
          '&maxResults=5',
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

  static Future<List<VideoItem>> fetchAllLatestVideos(String channelId, {int maxResults = 20}) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search'
          '?key=${AppConstants.youtubeApiKey}'
          '&channelId=$channelId'
          '&part=snippet,id'
          '&order=date'
          '&maxResults=$maxResults',
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

  static Future<List<VideoItem>> searchYouTube(String query, String channelId) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search'
          '?key=${AppConstants.youtubeApiKey}'
          '&channelId=$channelId'
          '&q=$query'
          '&part=snippet'
          '&type=video'
          '&maxResults=10',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List items = jsonDecode(response.body)['items'];
      return items.map<VideoItem>((item) => VideoItem(
        title: item['snippet']['title'],
        thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
        videoId: item['id']['videoId'],
      )).toList();
    } else {
      throw Exception('Failed to search YouTube: ${response.body}');
    }
  }
}
