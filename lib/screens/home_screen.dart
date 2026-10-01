import 'package:flutter/material.dart';
import 'package:miracle_tv/core/constants.dart';
import 'package:miracle_tv/screens/favorites_screen.dart';
import 'package:miracle_tv/screens/live_screen.dart';
import 'package:miracle_tv/screens/profile_screen.dart';
import 'package:miracle_tv/screens/programs_screen.dart';
import 'package:miracle_tv/screens/videos_screen.dart';
import 'package:miracle_tv/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    _HomeTab(),
    VideosScreen(),
    LiveScreen(),
    ProgramsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Image.asset(
                  'assets/logos/mefdn_logo.png',
                  width: 56,
                  height: 56,
                  errorBuilder: (_, __, ___) {
                    return const CircleAvatar(
                      radius: 28,
                      child: Icon(Icons.church),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppConstants.appName,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppConstants.slogan,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/prophet_papa_star.jpg',
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const SizedBox(
                            height: 220,
                            width: double.infinity,
                            child: Center(child: Icon(Icons.image, size: 40)),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // navigation to live/videos
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF123D6A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('REGARDER MAINTENANT'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Vidéos récentes'),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _miniVideoCard('Culte de puissance', 'Aujourd’hui'),
                  _miniVideoCard('Message de courage', 'Hier'),
                  _miniVideoCard('Renouveau spirituel', 'Cette semaine'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Programmes'),
            const SizedBox(height: 12),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Culte de guérison'),
              subtitle: Text('Samedi • 17h00 • Centre de prière'),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Heure de prière'),
              subtitle: Text('Dimanche • 09h00 • Église centrale'),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('EN DIRECT'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.live_tv, color: Colors.red),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('EN DIRECT', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Culte de guérison en cours'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Ouvrir'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _miniVideoCard(String title, String subtitle) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=800&q=80',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
