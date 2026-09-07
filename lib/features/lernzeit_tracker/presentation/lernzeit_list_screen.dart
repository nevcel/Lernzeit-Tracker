import 'package:flutter/material.dart';

import '../data/lernzeit_firestore.dart';
import '../domain/lernzeit_session.dart';
import 'lernzeit_add_screen.dart';
import 'lernzeit_detail_screen.dart';

class LernzeitListScreen extends StatefulWidget {
  const LernzeitListScreen({super.key});

  @override
  State<LernzeitListScreen> createState() => _LernzeitListScreenState();
}

class _LernzeitListScreenState extends State<LernzeitListScreen> {
  // Geladene Lernzeiten
  late Future<List<LernzeitSession>> sessionsFuture;

  @override
  void initState() {
    super.initState();
    loadSessions();
  }

  // Lernzeiten laden
  void loadSessions() {
    sessionsFuture = getLernzeiten();
  }

  // Liste nach Änderungen neu laden
  void refreshSessions() {
    setState(() {
      loadSessions();
    });
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

      // Lernzeiten anzeigen
      body: FutureBuilder<List<LernzeitSession>>(
        future: sessionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Die Lernzeiten konnten nicht geladen werden.'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Keine Einträge gefunden.'));
          }

          final sessions = snapshot.data!;

          return ListView.builder(
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
                    '${session.subject} · ${session.formattedDuration}\n'
                    '${session.description}',
                  ),
                  trailing: const Icon(Icons.chevron_right),

                  // Detailansicht öffnen und danach Liste aktualisieren
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LernzeitDetailScreen(session: session),
                      ),
                    );

                    refreshSessions();
                  },
                ),
              );
            },
          );
        },
      ),

      // Neue Lernzeit erfassen
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LernzeitAddScreen()),
          );

          refreshSessions();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}