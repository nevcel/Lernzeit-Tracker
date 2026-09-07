import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Aktuell angemeldeter Benutzer
  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  // Änderungen des Login-Status beobachten
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  // Bestehenden Benutzer anmelden
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Neuen Benutzer registrieren
  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Benutzer abmelden
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}