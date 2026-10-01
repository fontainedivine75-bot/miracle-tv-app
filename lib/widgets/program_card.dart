import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String imageUrl;
  final VoidCallback onTap;

  const ProgramCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const SizedBox(
                    width: 110,
                    height: 110,
                    child: Center(child: Icon(Icons.image_not_supported)),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('$date • $time'),
                    const SizedBox(height: 4),
                    Text(location),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
