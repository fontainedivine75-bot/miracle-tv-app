import 'package:flutter/material.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videos = [
      {'title': 'Message de puissance', 'date': '12 mai 2026', 'description': 'Déclaration de présence divine'},
      {'title': 'Prière de guérison', 'date': '04 mai 2026', 'description': 'Renouveau spirituel et guérison'},
      {'title': 'Culte de lumière', 'date': '30 avr 2026', 'description': 'Une atmosphère de louange et de délivrance'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vidéos'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=700&q=80',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(video['title'] as String),
              subtitle: Text('${video['date']} • ${video['description']}'),
              trailing: PopupMenuButton<String>(
                onSelected: (_) {},
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'favorite', child: Text('Ajouter aux favoris')),
                  PopupMenuItem(value: 'share', child: Text('Partager')),
                  PopupMenuItem(value: 'details', child: Text('Voir les détails')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
