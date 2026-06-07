import 'package:flutter/material.dart';

// Profilseite der App.
// Diese Klasse zeigt den Profilbereich an, der später erweitert werden kann.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Obere App-Leiste mit dem Titel der Profilseite
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Inhalt des Profilbereichs
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text(
            // Platzhaltertext für zukünftige Profilinformationen
            'Profilbereich\n\nHier kommt später persönliche Lernziele, Name oder Statistiken.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
