import '../domain/lernzeit_session.dart';

final mockLernzeitSessions = const [
  LernzeitSession(
    title: 'Flutter Grundlagen',
    description: 'Widgets, Scaffold und einfache Layouts wiederholen.',
    durationSeconds: 2700, // 45 Minuten
    subject: 'Mobile Apps',
  ),
  LernzeitSession(
    title: 'Dart Klassen üben',
    description: 'Klassen, Konstruktoren und final-Attribute verstehen.',
    durationSeconds: 1800, // 30 Minuten
    subject: 'Programmierung',
  ),
  LernzeitSession(
    title: 'Projektstruktur planen',
    description:
        'Ordner wie app, features, data, domain und presentation sauber aufbauen.',
    durationSeconds: 3600, // 60 Minuten
    subject: 'Flutter Projekt',
  ),
];