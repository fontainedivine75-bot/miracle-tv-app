class VideoModel {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String youtubeVideoId;
  final String category;
  final DateTime publishedAt;
  final bool isPublished;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.youtubeVideoId,
    required this.category,
    required this.publishedAt,
    this.isPublished = true,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map, String id) {
    return VideoModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      youtubeVideoId: map['youtubeVideoId'] ?? '',
      category: map['category'] ?? 'Other',
      publishedAt: map['publishedAt'] != null
          ? DateTime.parse(map['publishedAt'])
          : DateTime.now(),
      isPublished: map['isPublished'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'youtubeVideoId': youtubeVideoId,
      'category': category,
      'publishedAt': publishedAt.toIso8601String(),
      'isPublished': isPublished,
    };
  }
}
