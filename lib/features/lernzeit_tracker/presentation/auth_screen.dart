import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService authService = AuthService();

  bool isLogin = true;
  bool isLoading = false;

  // Verständliche Fehlermeldungen für Firebase Authentication
  String getAuthErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-credential':
        return 'E-Mail-Adresse oder Passwort ist nicht korrekt.';

      case 'user-not-found':
        return 'Kein Benutzer mit dieser E-Mail-Adresse gefunden.';

      case 'wrong-password':
        return 'Das Passwort ist nicht korrekt.';

      case 'email-already-in-use':
        return 'Diese E-Mail-Adresse wird bereits verwendet.';

      case 'weak-password':
        return 'Das Passwort ist zu schwach.';

      case 'invalid-email':
        return 'Die E-Mail-Adresse ist ungültig.';

      case 'user-disabled':
        return 'Dieses Benutzerkonto wurde deaktiviert.';

      case 'too-many-requests':
        return 'Zu viele Versuche. Bitte versuche es später erneut.';

      case 'network-request-failed':
        return 'Keine Netzwerkverbindung. Bitte überprüfe deine Internetverbindung.';

      case 'operation-not-allowed':
        return 'Diese Anmeldemethode ist momentan nicht verfügbar.';

      default:
        return 'Es ist ein Fehler aufgetreten. Bitte versuche es erneut.';
    }
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (isLogin) {
        // Bestehenden Benutzer über den AuthService anmelden
        await authService.signIn(
          email: email,
          password: password,
        );
      } else {
        // Neuen Benutzer über den AuthService registrieren
        await authService.register(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              getAuthErrorMessage(error),
            ),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Es ist ein unerwarteter Fehler aufgetreten. Bitte versuche es erneut.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLogin ? 'Login' : 'Registrieren',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.school,
                      size: 72,
                      color: Colors.deepPurple,
                    ),

                    const SizedBox(height: 24),

                    // E-Mail-Adresse für Login oder Registrierung
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-Mail',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Bitte E-Mail eingeben';
                        }

                        if (!value.contains('@')) {
                          return 'Bitte gültige E-Mail eingeben';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Passwort wird verdeckt angezeigt
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Passwort',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Bitte Passwort eingeben';
                        }

                        if (value.trim().length < 6) {
                          return 'Passwort muss mindestens 6 Zeichen haben';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton.icon(
                      onPressed: isLoading ? null : submitForm,
                      icon: const Icon(Icons.login),
                      label: Text(
                        isLoading
                            ? 'Bitte warten...'
                            : isLogin
                                ? 'Einloggen'
                                : 'Registrieren',
                      ),
                    ),

                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                      child: Text(
                        isLogin
                            ? 'Noch kein Konto? Registrieren'
                            : 'Bereits ein Konto? Einloggen',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}