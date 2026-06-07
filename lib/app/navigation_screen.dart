import 'package:flutter/material.dart';
import '../features/lernzeit_tracker/presentation/lernzeit_list_screen.dart';
import '../features/info/presentation/info_screen.dart';
import '../features/profile/presentation/profile_screen.dart';

// Bildschirm mit der unteren Navigation
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // Speichert den aktuell ausgewählten Tab
  int currentIndex = 0;

  // Liste der Bildschirme, zwischen denen gewechselt wird
  final screens = const [LernzeitListScreen(), InfoScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Zeigt den Bildschirm passend zum ausgewählten Tab an
      body: screens[currentIndex],

      // Untere Navigationsleiste
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        // Wird ausgeführt, wenn ein Tab angeklickt wird
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        // Einzelne Navigationspunkte
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Lernzeiten'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
