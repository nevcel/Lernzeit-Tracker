import 'package:flutter/material.dart';

// Informationsseite der App
class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Obere App-Leiste mit Titel
      appBar: AppBar(
        title: const Text('Info'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Inhalt der Informationsseite
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text(
            // Beschreibung des Zwecks der App
            'Der Lernzeit Tracker hilft, meine Lernzeiten übersichtlich zu erfassen und meine Lernsessions besser im Blick zu behalten.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
