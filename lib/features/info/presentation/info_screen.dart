import 'package:flutter/material.dart';

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
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text(
            'Der Lernzeit Tracker hilft, meine Lernzeiten übersichtlich zu erfassen und meine Lernsessions besser im Blick zu behalten.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}