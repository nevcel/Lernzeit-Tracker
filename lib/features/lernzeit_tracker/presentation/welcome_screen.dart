import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onContinue;

  const WelcomeScreen({
    super.key,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Spacer(),

              // Eigenes App-Logo
              SvgPicture.asset(
                'assets/images/lernzeit_logo.svg',
                width: 150,
                height: 150,
              ),

              const SizedBox(height: 32),

              const Text(
                'Willkommen beim\nLernzeit Tracker',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Erfasse deine Lernzeiten einfach und übersichtlich. '
                'Behalte deine Lerneinheiten im Blick und verwalte deine '
                'persönlichen Einträge jederzeit.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              const Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Lernzeit mit dem integrierten Timer erfassen',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Row(
                children: [
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Lerneinträge anzeigen und bearbeiten',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Row(
                children: [
                  Icon(
                    Icons.cloud_outlined,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Persönliche Daten sicher in der Cloud speichern',
                    ),
                  ),
                ],
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                  onPressed: onContinue,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    'Loslegen',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}