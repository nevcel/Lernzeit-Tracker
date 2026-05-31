import 'package:flutter/material.dart';

import '../data/lernzeit_mock_data.dart';
import 'lernzeit_detail_screen.dart';

class LernzeitListScreen extends StatelessWidget {
  const LernzeitListScreen({super.key});

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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockLernzeitSessions.length,
        itemBuilder: (context, index) {
          final session = mockLernzeitSessions[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.timer),
              title: Text(session.title),
              subtitle: Text(
                '${session.subject} · ${session.durationMinutes} Minuten',
              ),
              trailing: const Icon(Icons.chevron_right),
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
