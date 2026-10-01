class FavoriteModel {
  final String userId;
  final String videoId;
  final DateTime addedAt;

  FavoriteModel({
    required this.userId,
    required this.videoId,
    required this.addedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'videoId': videoId,
      'addedAt': addedAt.toIso8601String(),
    };
  }
}
