import 'package:flutter/material.dart';

import 'navigation_screen.dart';

// Hauptklasse der App
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Titel der App
      title: 'Lernzeit Tracker',

      // Entfernt das Debug-Banner oben rechts
      debugShowCheckedModeBanner: false,

      // Zentrales Design der App
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        // Design-Einstellungen für alle AppBars
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
        ),

        useMaterial3: true,
      ),

      // Startbildschirm der App
      home: const NavigationScreen(),
    );
  }
}
