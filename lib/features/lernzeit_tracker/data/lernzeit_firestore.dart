import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/lernzeit_session.dart';

// Firestore-Collection des aktuell angemeldeten Benutzers
CollectionReference<Map<String, dynamic>> lernzeitenCollection() {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('Kein Benutzer angemeldet.');
  }

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('lernzeit_tracker_collection');
}

// Neue Lernzeit in Firestore erstellen
Future<void> createLernzeit({
  required String title,
  required String subject,
  required String description,
  required int durationSeconds,
}) async {
  final session = LernzeitSession(
    title: title,
    subject: subject,
    description: description,
    durationSeconds: durationSeconds,
  );

  await lernzeitenCollection().add(session.toMap());
}

// Lernzeiten aus Firestore laden
Future<List<LernzeitSession>> getLernzeiten() async {
  final snapshot = await lernzeitenCollection().get();

  return snapshot.docs.map((doc) {
    return LernzeitSession.fromMap(doc.data(), id: doc.id);
  }).toList();
}

// Bestehende Lernzeit in Firestore aktualisieren
Future<void> updateLernzeit({
  required String id,
  required String title,
  required String subject,
  required String description,
  required int durationSeconds,
}) async {
  final session = LernzeitSession(
    id: id,
    title: title,
    subject: subject,
    description: description,
    durationSeconds: durationSeconds,
  );

  await lernzeitenCollection().doc(id).update(session.toMap());
}

// Bestehende Lernzeit aus Firestore löschen
Future<void> deleteLernzeit({required String id}) async {
  await lernzeitenCollection().doc(id).delete();
}
