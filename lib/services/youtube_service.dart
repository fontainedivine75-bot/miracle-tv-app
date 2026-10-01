class YouTubeService {
  static const String baseUrl = 'https://www.youtube.com';
  static const String channelUrl = baseUrl + '/channel/UCrLQRc9n9JFClAqhWd5cngg';

  /// Get YouTube thumbnail URL from video ID
  static String getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }

  /// Get alternative thumbnail URL if maxresdefault is not available
  static String getThumbnailUrlAlternative(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/sddefault.jpg';
  }
}
