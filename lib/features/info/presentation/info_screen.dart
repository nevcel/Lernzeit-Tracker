import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Eigenes SVG-Asset
              SvgPicture.asset(
                'assets/images/lernzeit_logo.svg',
                width: 140,
                height: 140,
              ),

              const SizedBox(height: 32),

              const Text(
                'Lernzeit Tracker',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Mit dem Lernzeit Tracker können persönliche Lernzeiten '
                'erfasst, gespeichert, bearbeitet und verwaltet werden.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Die Lernzeiten werden benutzerbezogen in Cloud Firestore gespeichert.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}