import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/lernzeit_tracker/presentation/auth_screen.dart';
import '../features/lernzeit_tracker/presentation/welcome_screen.dart';
import 'navigation_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<bool> onboardingFuture;

  @override
  void initState() {
    super.initState();
    onboardingFuture = isOnboardingCompleted();
  }

  // Prüfen, ob der Welcome-Screen bereits abgeschlossen wurde
  Future<bool> isOnboardingCompleted() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool('onboarding_completed') ?? false;
  }

  // Welcome-Screen als abgeschlossen speichern
  Future<void> completeOnboarding() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(
      'onboarding_completed',
      true,
    );

    if (mounted) {
      setState(() {
        onboardingFuture = Future.value(true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lernzeit Tracker',
      debugShowCheckedModeBanner: false,

      // Zentrales Erscheinungsbild der App
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),

        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
        ),

        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.deepPurple,
        ),

        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),

      // Zuerst prüfen, ob das Onboarding bereits angezeigt wurde
      home: FutureBuilder<bool>(
        future: onboardingFuture,
        builder: (context, onboardingSnapshot) {
          if (onboardingSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // Beim ersten App-Start Welcome-Screen anzeigen
          if (onboardingSnapshot.data != true) {
            return WelcomeScreen(
              onContinue: completeOnboarding,
            );
          }

          // Danach Login-Status prüfen
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, authSnapshot) {
              if (authSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // Eingeloggt: Haupt-App anzeigen
              if (authSnapshot.hasData) {
                return const NavigationScreen();
              }

              // Nicht eingeloggt: Login anzeigen
              return const AuthScreen();
            },
          );
        },
      ),
    );
  }
}