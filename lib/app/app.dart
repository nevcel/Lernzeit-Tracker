import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../features/lernzeit_tracker/presentation/auth_screen.dart';
import 'navigation_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lernzeit Tracker',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        // Prüft laufend, ob ein Benutzer eingeloggt ist
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Während Firebase den Login-Status prüft
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // Eingeloggt: App anzeigen
          if (snapshot.hasData) {
            return const NavigationScreen();
          }

          // Nicht eingeloggt: Login anzeigen
          return const AuthScreen();
        },
      ),
    );
  }
}