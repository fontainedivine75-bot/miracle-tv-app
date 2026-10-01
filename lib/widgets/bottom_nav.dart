import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
      BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Vidéos'),
      BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Direct'),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Programme'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
    ];

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: items,
    );
  }
}
