import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase wird vor dem App-Start initialisiert
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Die App meldet sich anonym an, falls noch kein Benutzer vorhanden ist
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  runApp(const App());
}

// Zeigt auf die Lernzeiten des aktuell angemeldeten Benutzers
CollectionReference<Map<String, dynamic>> lernzeitenCollection() {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('lernzeit_tracker_collection');
}