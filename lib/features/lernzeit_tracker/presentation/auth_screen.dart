import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;

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
      // Bestehenden Benutzer anmelden
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else {
      // Neuen Benutzer registrieren
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
  } on FirebaseAuthException catch (error) {
    String message = 'Anmeldung fehlgeschlagen.';

    if (error.code == 'user-not-found') {
      message = 'Kein Benutzer mit dieser E-Mail gefunden.';
    } else if (error.code == 'wrong-password') {
      message = 'Das Passwort ist falsch.';
    } else if (error.code == 'email-already-in-use') {
      message = 'Diese E-Mail-Adresse wird bereits verwendet.';
    } else if (error.code == 'weak-password') {
      message = 'Das Passwort ist zu schwach.';
    } else if (error.code == 'invalid-email') {
      message = 'Die E-Mail-Adresse ist ungültig.';
    } else if (error.code == 'operation-not-allowed') {
      message = 'E-Mail/Passwort ist in Firebase nicht aktiviert.';
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  } catch (error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fehler: $error'),
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
        title: Text(isLogin ? 'Login' : 'Registrieren'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
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
                        border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
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