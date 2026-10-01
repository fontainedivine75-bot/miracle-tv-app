class ProgramModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String imageUrl;
  final bool isPublished;
  final DateTime createdAt;

  ProgramModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
    this.isPublished = true,
    required this.createdAt,
  });

  factory ProgramModel.fromMap(Map<String, dynamic> map, String id) {
    return ProgramModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      location: map['location'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      isPublished: map['isPublished'] ?? true,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'imageUrl': imageUrl,
      'isPublished': isPublished,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
