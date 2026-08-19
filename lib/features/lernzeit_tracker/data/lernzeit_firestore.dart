import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Firestore-Collection des aktuell angemeldeten Benutzers
CollectionReference<Map<String, dynamic>> lernzeitenCollection() {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('lernzeit_tracker_collection');
}