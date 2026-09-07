import 'package:flutter/material.dart';

import '../features/info/presentation/info_screen.dart';
import '../features/lernzeit_tracker/presentation/lernzeit_list_screen.dart';
import '../features/profile/presentation/profile_screen.dart';

// Bildschirm mit der globalen Hauptnavigation
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // Speichert den aktuell ausgewählten Tab
  int currentIndex = 0;

  // Hauptbereiche der App
  final screens = const [
    LernzeitListScreen(),
    InfoScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack erhält den Zustand der einzelnen Tabs
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      // Untere Hauptnavigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            activeIcon: Icon(Icons.timer),
            label: 'Lernzeiten',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            activeIcon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}