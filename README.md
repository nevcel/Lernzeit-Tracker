# Lernzeit Tracker

Der Lernzeit Tracker ist eine Flutter-Anwendung zur strukturierten Erfassung und Verwaltung persönlicher Lernzeiten.

Benutzerinnen und Benutzer können eigene Lerneinträge erstellen, anzeigen, bearbeiten und löschen. Die Daten werden dauerhaft und benutzerbezogen in Cloud Firestore gespeichert. Die Anmeldung erfolgt über Firebase Authentication mit E-Mail-Adresse und Passwort.

## Funktionen

- Benutzeranmeldung mit E-Mail und Passwort
- Benutzerabmeldung mit Logout
- Lernzeiten erstellen
- Lernzeiten anzeigen
- Lernzeiten bearbeiten
- Lernzeiten löschen
- Benutzerbezogene Datenspeicherung
- Synchronisation mit Cloud Firestore
- Eingabevalidierung
- Lade-, Leer- und Fehlerzustände

## Technologien

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore

## Projektstruktur

```text
lib/
├── main.dart
├── firebase_options.dart
│
├── app/
│   ├── app.dart
│   └── navigation_screen.dart
│
└── features/
    ├── auth/
    │   └── presentation/
    │
    ├── tasks/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── info/
    │   └── presentation/
    │
    └── profile/
        └── presentation/