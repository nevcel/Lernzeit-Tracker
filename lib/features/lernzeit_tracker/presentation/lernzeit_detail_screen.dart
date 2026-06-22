import 'package:flutter/material.dart';

import '../domain/lernzeit_session.dart';
import 'lernzeit_edit_screen.dart';

class LernzeitDetailScreen extends StatelessWidget {
  final LernzeitSession session;

  const LernzeitDetailScreen({super.key, required this.session});

  Future<void> openEditScreen(BuildContext context) async {
    final updatedSession = await Navigator.push<LernzeitSession>(
      context,
      MaterialPageRoute(
        builder: (context) => LernzeitEditScreen(session: session),
      ),
    );

    // Bearbeiteten Eintrag an die Listenansicht zurückgeben
    if (updatedSession != null && context.mounted) {
      Navigator.pop(context, updatedSession);
    }
  }

  Future<void> confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eintrag löschen'),
          content: const Text('Möchtest du diese Lernzeit wirklich löschen?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Löschen'),
            ),
          ],
        );
      },
    );

    // Löschbefehl an die Listenansicht zurückgeben
    if (shouldDelete == true && context.mounted) {
      Navigator.pop(context, 'delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(session.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  session.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.school),
                    const SizedBox(width: 8),
                    Text('Fach: ${session.subject}'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(width: 8),
                    Text('Dauer: ${session.formattedDuration}'),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  session.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),

                // Aktionen für den aktuellen Eintrag
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          openEditScreen(context);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Bearbeiten'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          confirmDelete(context);
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Löschen'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}