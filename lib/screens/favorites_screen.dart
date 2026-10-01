import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miracle_tv/core/constants.dart';
import 'package:miracle_tv/services/firestore_service.dart';
import 'package:miracle_tv/screens/video_player_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final _firestoreService = FirestoreService();

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
        elevation: 0,
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          final user = authSnapshot.data;

          if (user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_outline, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'Connectez-vous pour voir vos favoris',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return StreamBuilder<List<String>>(
            stream: _firestoreService.fetchUserFavorites(user.uid),
            builder: (context, favSnapshot) {
              if (favSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final favoriteIds = favSnapshot.data ?? [];

              if (favoriteIds.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite_outline,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Aucune video favorie',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }

              return StreamBuilder<List<DocumentSnapshot>>(
                stream: FirebaseFirestore.instance
                    .collection(FirestoreCollections.videos)
                    .where(FieldPath.documentId, whereIn: favoriteIds)
                    .snapshots()
                    .map((snapshot) => snapshot.docs),
                builder: (context, videosSnapshot) {
                  if (videosSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final videos = videosSnapshot.data ?? [];

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final videoData =
                          videos[index].data() as Map<String, dynamic>;
                      final videoId = videos[index].id;
                      final title = videoData['title'] ?? 'Sans titre';
                      final thumbnail = videoData['thumbnailUrl'] ?? '';
                      final category = videoData['category'] ?? 'Autre';

                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigate to video player
                                  },
                                  child: Image.network(
                                    thumbnail,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: Colors.grey.shade300,
                                      child: const Center(
                                        child: Icon(Icons.video_library),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
