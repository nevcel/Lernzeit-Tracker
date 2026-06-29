import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../domain/lernzeit_session.dart';
import 'lernzeit_add_screen.dart';
import 'lernzeit_detail_screen.dart';

class LernzeitListScreen extends StatefulWidget {
  const LernzeitListScreen({super.key});

  @override
  State<LernzeitListScreen> createState() => _LernzeitListScreenState();
}

class _LernzeitListScreenState extends State<LernzeitListScreen> {
  // Firestore-Collection für die Lernzeiten
  static const String collectionName = 'lernzeit_tracker_collection';

  // Firestore-Abfrage für die Liste
  late Future<QuerySnapshot<Map<String, dynamic>>> sessionsFuture;

  @override
  void initState() {
    super.initState();
    loadSessions();
  }

  // Lernzeiten aus Firestore laden
  void loadSessions() {
    sessionsFuture =
        FirebaseFirestore.instance.collection(collectionName).get();
  }

  // Liste nach Änderungen neu laden
  void refreshSessions() {
    setState(() {
      loadSessions();
    });
  }

  // Firestore-Dokument in ein LernzeitSession-Objekt umwandeln
  LernzeitSession sessionFromDocument(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    return LernzeitSession(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      subject: data['subject'] ?? '',
      durationSeconds: (data['durationSeconds'] as num?)?.toInt() ?? 0,
    );
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

      // Lernzeiten werden aus Firestore angezeigt
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: sessionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Fehler beim Laden: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Keine Einträge gefunden.'),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final session = sessionFromDocument(docs[index]);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: Text(session.title),
                  subtitle: Text(
                    '${session.subject} · ${session.formattedDuration}\n${session.description}',
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
            MaterialPageRoute(
              builder: (context) => const LernzeitAddScreen(),
            ),
          );

          refreshSessions();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}