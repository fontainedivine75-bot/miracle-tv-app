class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.isAdmin = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? 'Utilisateur',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      isAdmin: map['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'isAdmin': isAdmin,
    };
  }
}
