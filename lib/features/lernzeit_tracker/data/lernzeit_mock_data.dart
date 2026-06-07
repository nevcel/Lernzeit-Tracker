import '../domain/lernzeit_session.dart';

// Beispiel-Daten für Lernzeit-Sessions
final mockLernzeitSessions = const [
  LernzeitSession(
    title: 'Flutter Grundlagen',
    description: 'Widgets, Scaffold und einfache Layouts wiederholen.',
    durationMinutes: 45,
    subject: 'Mobile Apps',
  ),
  LernzeitSession(
    title: 'Dart Klassen üben',
    description: 'Klassen, Konstruktoren und final-Attribute verstehen.',
    durationMinutes: 30,
    subject: 'Programmierung',
  ),
  LernzeitSession(
    title: 'Projektstruktur planen',
    description:
        'Ordner wie app, features, data, domain und presentation sauber aufbauen.',
    durationMinutes: 60,
    subject: 'Flutter Projekt',
  ),
];