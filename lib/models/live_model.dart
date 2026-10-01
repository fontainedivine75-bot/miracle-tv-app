class LiveModel {
  final String id;
  final String videoId;
  final String title;
  final bool isLive;
  final DateTime updatedAt;

  LiveModel({
    required this.id,
    required this.videoId,
    required this.title,
    required this.isLive,
    required this.updatedAt,
  });

  factory LiveModel.fromMap(Map<String, dynamic> map, String id) {
    return LiveModel(
      id: id,
      videoId: map['videoId'] ?? '',
      title: map['title'] ?? '',
      isLive: map['isLive'] ?? false,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'title': title,
      'isLive': isLive,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
