class VideoModel {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String youtubeVideoId;
  final String category;
  final String publishedAt;
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
      title: map['title'] ?? 'Titre',
      description: map['description'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      youtubeVideoId: map['youtubeVideoId'] ?? '',
      category: map['category'] ?? 'Autre',
      publishedAt: map['publishedAt'] ?? '',
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
      'publishedAt': publishedAt,
      'isPublished': isPublished,
    };
  }
}
