import 'package:flutter/material.dart';

import '../data/lernzeit_mock_data.dart';
import '../domain/lernzeit_session.dart';
import 'lernzeit_add_screen.dart';
import 'lernzeit_detail_screen.dart';

class LernzeitListScreen extends StatefulWidget {
  const LernzeitListScreen({super.key});

  @override
  State<LernzeitListScreen> createState() => _LernzeitListScreenState();
}

class _LernzeitListScreenState extends State<LernzeitListScreen> {
  // Veränderbare Liste der Lernzeit-Einträge
  late List<LernzeitSession> sessions;

  @override
  void initState() {
    super.initState();

    // Startdaten aus den Mockup-Daten übernehmen
    sessions = List.from(mockLernzeitSessions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lernzeit Tracker'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Anzeige aller gespeicherten Lernzeiten
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.timer),
              title: Text(session.title),
              subtitle: Text(
                '${session.subject} · ${session.formattedDuration}',
              ),
              trailing: const Icon(Icons.chevron_right),

              // Öffnet die Detailansicht des ausgewählten Eintrags
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LernzeitDetailScreen(session: session),
                  ),
                );

                // Aktualisiert den Eintrag nach dem Bearbeiten
                if (result is LernzeitSession) {
                  setState(() {
                    sessions[index] = result;
                  });
                }

                // Entfernt den Eintrag nach dem Löschen
                if (result == 'delete') {
                  setState(() {
                    sessions.removeAt(index);
                  });
                }
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newSession = await Navigator.push<LernzeitSession>(
            context,
            MaterialPageRoute(builder: (context) => const LernzeitAddScreen()),
          );

          if (newSession != null) {
            setState(() {
              sessions.add(newSession);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
