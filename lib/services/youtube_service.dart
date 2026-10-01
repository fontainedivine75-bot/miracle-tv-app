import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeService {
  final String youtubeChannelUrl;

  YouTubeService({required this.youtubeChannelUrl});

  Future<Map<String, dynamic>> fetchChannelVideos() async {
    final response = await http.get(
      Uri.parse(
        'https://www.youtube.com/feeds/videos.xml?channel_id=UCrLQRc9n9JFClAqhWd5cngg',
      ),
    );

    if (response.statusCode == 200) {
      return {'status': 'ok', 'data': utf8.decode(response.bodyBytes)};
    }

    return {'status': 'error', 'data': null};
  }
}
