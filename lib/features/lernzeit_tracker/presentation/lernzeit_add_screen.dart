import 'dart:async';

import 'package:flutter/material.dart';

import '../data/lernzeit_firestore.dart';

class LernzeitAddScreen extends StatefulWidget {
  const LernzeitAddScreen({super.key});

  @override
  State<LernzeitAddScreen> createState() => _LernzeitAddScreenState();
}

class _LernzeitAddScreenState extends State<LernzeitAddScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  Timer? timer;
  int elapsedSeconds = 0;
  bool isStopped = false;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // Timer für die aktuelle Lernsession
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++;
      });
    });
  }

  // Timer stoppen und Formular anzeigen
  void stopTimer() {
    timer?.cancel();

    setState(() {
      isStopped = true;
    });
  }

  // Anzeige der gemessenen Lernzeit
  String get formattedTime {
    final hours = elapsedSeconds ~/ 3600;
    final minutes = (elapsedSeconds % 3600) ~/ 60;
    final seconds = elapsedSeconds % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')} h';
  }

  // Motivation abhängig von der Dauer der Lernsession
  String get successMessage {
    if (elapsedSeconds < 600) {
      return 'Kleine Schritte zählen! 🌱';
    }

    if (elapsedSeconds < 1800) {
      return 'Gute Session! Weiter so. 💪';
    }

    if (elapsedSeconds < 3600) {
      return 'Starke Leistung! 🔥';
    }

    return 'Wow – richtig starke Lernsession! 🏆';
  }

  // Erfolgsmeldung nach dem Speichern anzeigen
  Future<void> showSuccessDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Lernsession abgeschlossen! 🎉',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.celebration,
                size: 64,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),

              Text(
                'Du hast $formattedTime gelernt.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                successMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Weiter'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveSession() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      // Neue Lernzeit im Benutzerbereich speichern
      await createLernzeit(
        title: titleController.text.trim(),
        subject: subjectController.text.trim(),
        description: descriptionController.text.trim(),
        durationSeconds: elapsedSeconds,
      );

      if (!mounted) {
        return;
      }

      // Erfolgsmoment nach erfolgreichem Speichern
      await showSuccessDialog();

      if (!mounted) {
        return;
      }

      Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Die Lernzeit konnte nicht gespeichert werden. '
            'Bitte versuche es erneut.',
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
    timer?.cancel();
    titleController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Lernzeit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: isStopped ? buildFormView() : buildTimerView(),
      ),
    );
  }

  Widget buildTimerView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.timer,
            size: 120,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 32),
          Text(
            formattedTime,
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: stopTimer,
            icon: const Icon(Icons.stop),
            label: const Text('Stopp'),
          ),
        ],
      ),
    );
  }

  Widget buildFormView() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Text(
            'Gemessene Lernzeit: $formattedTime',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Titel',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Bitte Titel eingeben';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: subjectController,
            decoration: const InputDecoration(
              labelText: 'Fach',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Bitte Fach eingeben';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Beschreibung',
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
            onPressed: isSaving ? null : saveSession,
            icon: const Icon(Icons.save),
            label: Text(
              isSaving ? 'Speichern...' : 'Speichern',
            ),
          ),
        ],
      ),
    );
  }
}