import 'dart:async';

import 'package:flutter/material.dart';

import '../domain/lernzeit_session.dart';

class LernzeitAddScreen extends StatefulWidget {
  const LernzeitAddScreen({super.key});

  @override
  State<LernzeitAddScreen> createState() => _LernzeitAddScreenState();
}

class _LernzeitAddScreenState extends State<LernzeitAddScreen> {
  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  Timer? timer;
  int elapsedSeconds = 0;
  bool isStopped = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // Startet die Zeitmessung für die Lernsession
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++;
      });
    });
  }

  // Stoppt die Zeitmessung und zeigt danach das Formular an
  void stopTimer() {
    timer?.cancel();

    setState(() {
      isStopped = true;
    });
  }

  // Formatiert Sekunden als hh:mm:ss
  String get formattedTime {
    final hours = elapsedSeconds ~/ 3600;
    final minutes = (elapsedSeconds % 3600) ~/ 60;
    final seconds = elapsedSeconds % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} h';
  }

  // Erstellt eine neue Lernsession und gibt sie an die Liste zurück
 void saveSession() {
  final title = titleController.text.trim();
  final subject = subjectController.text.trim();
  final description = descriptionController.text.trim();

  // Prüft, ob alle Pflichtfelder ausgefüllt sind
  if (title.isEmpty || subject.isEmpty || description.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bitte Titel, Fach und Beschreibung ausfüllen.'),
      ),
    );
    return;
  }

  final newSession = LernzeitSession(
    title: title,
    subject: subject,
    description: description,
    durationSeconds: elapsedSeconds,
  );

  Navigator.pop(context, newSession);
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
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
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
          size: 200,
          color: Colors.deepPurple,
        ),
        const SizedBox(height: 32),
        Text(
          formattedTime,
          style: const TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 60),
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
    return ListView(
      children: [
        Text(
          'Gemessene Lernzeit: $formattedTime',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        // Titel der Lernsession
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Titel',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // Fach oder Thema der Lernsession
        TextField(
          controller: subjectController,
          decoration: const InputDecoration(
            labelText: 'Fach',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // Kurze Beschreibung der Lernsession
        TextField(
          controller: descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Beschreibung',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: saveSession,
          icon: const Icon(Icons.save),
          label: const Text('Speichern'),
        ),
      ],
    );
  }
}