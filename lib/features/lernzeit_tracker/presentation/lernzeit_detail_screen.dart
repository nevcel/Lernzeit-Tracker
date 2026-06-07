import 'package:flutter/material.dart';

import '../domain/lernzeit_session.dart';

// Detailseite für eine einzelne Lernzeit-Session.
// Diese Klasse zeigt alle wichtigen Informationen einer ausgewählten Lernsession an.
class LernzeitDetailScreen extends StatelessWidget {
  // Die Lernsession, deren Details angezeigt werden sollen
  final LernzeitSession session;

  const LernzeitDetailScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Obere App-Leiste mit dem Titel der aktuellen Lernsession
      appBar: AppBar(
        title: Text(session.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Hauptinhalt der Detailseite
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),

            // Ordnet die Detailinformationen untereinander an
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titel der Lernsession
                Text(
                  session.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),

                // Anzeige des Fachs
                Row(
                  children: [
                    const Icon(Icons.school),
                    const SizedBox(width: 8),
                    Text('Fach: ${session.subject}'),
                  ],
                ),
                const SizedBox(height: 12),

                // Anzeige der Dauer
                Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(width: 8),
                    Text('Dauer: ${session.durationMinutes} Minuten'),
                  ],
                ),
                const SizedBox(height: 24),

                // Beschreibung der Lernsession
                Text(
                  session.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
