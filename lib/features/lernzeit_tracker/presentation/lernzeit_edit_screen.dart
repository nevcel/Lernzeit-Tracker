import 'package:flutter/material.dart';

import '../data/lernzeit_firestore.dart';
import '../domain/lernzeit_session.dart';

class LernzeitEditScreen extends StatefulWidget {
  final LernzeitSession session;

  const LernzeitEditScreen({super.key, required this.session});

  @override
  State<LernzeitEditScreen> createState() => _LernzeitEditScreenState();
}

class _LernzeitEditScreenState extends State<LernzeitEditScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    // Bestehende Werte werden in die Felder übernommen
    titleController.text = widget.session.title;
    subjectController.text = widget.session.subject;
    descriptionController.text = widget.session.description;
  }

  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (widget.session.id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Eintrag konnte nicht bearbeitet werden.'),
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      // Bestehende Lernzeit im Benutzerbereich aktualisieren
      await updateLernzeit(
        id: widget.session.id,
        title: titleController.text.trim(),
        subject: subjectController.text.trim(),
        description: descriptionController.text.trim(),
        durationSeconds: widget.session.durationSeconds,
      );
      if (!mounted) {
        return;
      }

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Die Lernzeit konnte nicht aktualisiert werden. Bitte versuche es erneut.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
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
        elevation: 4,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Gespeicherte Lernzeit: ${widget.session.formattedDuration}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

            // Beschreibung zur Lernsession
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: isSaving ? null : saveChanges,
              icon: const Icon(Icons.save),
              label: Text(isSaving ? 'Speichern...' : 'Änderungen speichern'),
            ),
          ],
        ),
      ),
    );
  }
}
