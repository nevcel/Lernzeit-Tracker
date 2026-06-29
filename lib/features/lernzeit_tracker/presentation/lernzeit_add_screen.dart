import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LernzeitAddScreen extends StatefulWidget {
  const LernzeitAddScreen({super.key});

  @override
  State<LernzeitAddScreen> createState() => _LernzeitAddScreenState();
}

class _LernzeitAddScreenState extends State<LernzeitAddScreen> {
  static const String collectionName = 'lernzeit_tracker_collection';

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

  // Startet den Timer für die Lernzeit
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++;
      });
    });
  }

  // Stoppt den Timer und zeigt das Formular an
  void stopTimer() {
    timer?.cancel();

    setState(() {
      isStopped = true;
    });
  }

  // Sekunden werden für die Anzeige formatiert
  String get formattedTime {
    final hours = elapsedSeconds ~/ 3600;
    final minutes = (elapsedSeconds % 3600) ~/ 60;
    final seconds = elapsedSeconds % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} h';
  }

  Future<void> saveSession() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSaving = true;
    });

    // Neue Lernzeit wird in Firestore gespeichert
    await FirebaseFirestore.instance.collection(collectionName).add({
      'title': titleController.text.trim(),
      'subject': subjectController.text.trim(),
      'description': descriptionController.text.trim(),
      'durationSeconds': elapsedSeconds,
    });

    if (mounted) {
      Navigator.pop(context, true);
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
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
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
            onPressed: isSaving ? null : saveSession,
            icon: const Icon(Icons.save),
            label: Text(isSaving ? 'Speichern...' : 'Speichern'),
          ),
        ],
      ),
    );
  }
}