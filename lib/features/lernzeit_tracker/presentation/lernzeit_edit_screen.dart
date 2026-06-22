import 'package:flutter/material.dart';

import '../domain/lernzeit_session.dart';

class LernzeitEditScreen extends StatefulWidget {
  final LernzeitSession session;

  const LernzeitEditScreen({
    super.key,
    required this.session,
  });

  @override
  State<LernzeitEditScreen> createState() => _LernzeitEditScreenState();
}

class _LernzeitEditScreenState extends State<LernzeitEditScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Bestehende Werte in die Eingabefelder übernehmen
    titleController.text = widget.session.title;
    subjectController.text = widget.session.subject;
    descriptionController.text = widget.session.description;
  }

  void saveChanges() {
    // Eingaben prüfen, bevor gespeichert wird
    if (!formKey.currentState!.validate()) {
      return;
    }

    final updatedSession = LernzeitSession(
      title: titleController.text.trim(),
      subject: subjectController.text.trim(),
      description: descriptionController.text.trim(),
      durationSeconds: widget.session.durationSeconds,
    );

    // Bearbeiteten Eintrag an die Detailseite zurückgeben
    Navigator.pop(context, updatedSession);
  }

  @override
  void dispose() {
    // Controller freigeben
    titleController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lernzeit bearbeiten'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Gespeicherte Lernzeit: ${widget.session.formattedDuration}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // Titel der Lernsession
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Titel',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Bitte Titel eingeben';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Fach oder Thema der Lernsession
            TextFormField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: 'Fach',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Bitte Fach eingeben';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Beschreibung der Lernsession
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Beschreibung',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Bitte Beschreibung eingeben';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: saveChanges,
              icon: const Icon(Icons.save),
              label: const Text('Änderungen speichern'),
            ),
          ],
        ),
      ),
    );
  }
}