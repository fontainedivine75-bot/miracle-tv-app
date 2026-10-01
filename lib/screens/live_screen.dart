import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EN DIRECT')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.live_tv, color: Colors.red, size: 48),
                    SizedBox(height: 8),
                    Text(
                      'Aucun direct actuellement',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Culte de puissance et d’onction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.fullscreen),
                  label: const Text('Plein écran'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('YouTube'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
