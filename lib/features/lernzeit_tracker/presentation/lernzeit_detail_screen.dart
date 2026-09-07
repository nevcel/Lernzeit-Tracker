import 'package:flutter/material.dart';

import '../data/lernzeit_firestore.dart';
import '../domain/lernzeit_session.dart';
import 'lernzeit_edit_screen.dart';

class LernzeitDetailScreen extends StatelessWidget {
  final LernzeitSession session;

  const LernzeitDetailScreen({
    super.key,
    required this.session,
  });

  Future<void> openEditScreen(BuildContext context) async {
    final wasSaved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => LernzeitEditScreen(
          session: session,
        ),
      ),
    );

    if (!context.mounted) {
      return;
    }

    // Nach dem Bearbeiten zurück zur Liste
    if (wasSaved == true) {
      Navigator.pop(context);
    }
  }

  Future<void> confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eintrag löschen'),
          content: const Text(
            'Möchtest du diese Lernzeit wirklich löschen?',
          ),
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

    if (!context.mounted) {
      return;
    }

    if (shouldDelete == true) {
      await deleteSession(context);
    }
  }

  Future<void> deleteSession(BuildContext context) async {
    if (session.id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Eintrag konnte nicht gelöscht werden.',
          ),
        ),
      );
      return;
    }

    try {
      await deleteLernzeit(
        id: session.id,
      );

      if (!context.mounted) {
        return;
      }

      Navigator.pop(context);
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Die Lernzeit konnte nicht gelöscht werden. Bitte versuche es erneut.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(session.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Expanded(
                      child: Text(
                        'Fach: ${session.subject}',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Dauer: ${session.formattedDuration}',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Text(
                  session.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 32),

                // Responsive Aktionen:
                // Auf kleinen Displays untereinander,
                // auf breiteren Displays nebeneinander.
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 360;

                    if (isNarrow) {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                openEditScreen(context);
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text('Bearbeiten'),
                            ),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,
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
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}