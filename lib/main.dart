import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase wird vor dem Start der App vorbereitet
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

/*
// Zeigt auf die Lernzeiten des aktuell angemeldeten Benutzers
CollectionReference<Map<String, dynamic>> lernzeitenCollection() {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('lernzeit_tracker_collection');
}
*/