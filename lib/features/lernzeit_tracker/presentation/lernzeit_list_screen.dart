import 'package:flutter/material.dart';

import '../data/lernzeit_mock_data.dart';
import 'lernzeit_detail_screen.dart';

// Übersichtsseite für alle Lernzeit-Sessions.
// Diese Klasse zeigt die vorhandenen Lernsessions als Liste an.
class LernzeitListScreen extends StatelessWidget {
  const LernzeitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Obere App-Leiste mit dem Titel der App
      appBar: AppBar(
        title: const Text('Lernzeit Tracker'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Erstellt eine scrollbare Liste aus den vorhandenen Lernzeit-Daten
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockLernzeitSessions.length,
        itemBuilder: (context, index) {
          // Holt die aktuelle Lernsession aus der Liste
          final session = mockLernzeitSessions[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),

            // Einzelner Listeneintrag für eine Lernsession
            child: ListTile(
              leading: const Icon(Icons.timer),
              title: Text(session.title),
              subtitle: Text(
                '${session.subject} · ${session.durationMinutes} Minuten',
              ),
              trailing: const Icon(Icons.chevron_right),

              // Öffnet die Detailseite der ausgewählten Lernsession
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LernzeitDetailScreen(session: session),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
