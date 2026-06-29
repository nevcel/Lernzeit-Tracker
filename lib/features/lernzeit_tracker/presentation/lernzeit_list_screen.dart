import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LernzeitListScreen extends StatelessWidget {
  const LernzeitListScreen({super.key});

  // Name der Firestore-Collection
  static const String collectionName = 'lernzeit_tracker_collection';

  // Sekunden werden in ein lesbares Zeitformat umgewandelt
  String formatDuration(int durationSeconds) {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    final seconds = durationSeconds % 60;

    return '${hours}h ${minutes}min ${seconds}s';
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

      // Firestore-Daten werden einmalig geladen
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection(collectionName).get(),
        builder: (context, snapshot) {
          // Anzeige während dem Laden
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Fehleranzeige, falls Firestore nicht geladen werden kann
          if (snapshot.hasError) {
            return Center(
              child: Text('Fehler beim Laden: ${snapshot.error}'),
            );
          }

          // Anzeige, wenn keine Dokumente vorhanden sind
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
              final data = docs[index].data();

              final title = data['title'] ?? '';
              final description = data['description'] ?? '';
              final subject = data['subject'] ?? '';
              final durationSeconds = data['durationSeconds'] ?? 0;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: Text(title),
                  subtitle: Text(
                    '$subject · ${formatDuration(durationSeconds)}\n$description',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}