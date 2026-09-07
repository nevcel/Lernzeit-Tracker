# Lernzeit Tracker

Der **Lernzeit Tracker** ist eine mit Flutter entwickelte App zur Erfassung und Verwaltung persönlicher Lernzeiten. Benutzer können ihre Lerneinträge übersichtlich erfassen, bearbeiten und verwalten.

## Funktionen

- Registrierung, Anmeldung und Abmeldung mit E-Mail und Passwort
- Persönliche Lernzeiteinträge erfassen
- Gespeicherte Einträge anzeigen
- Bestehende Einträge bearbeiten
- Einträge nach Bestätigung löschen
- Eingabevalidierung und verständliche Fehlermeldungen
- Lade- und Leerzustände
- Benutzerbezogene Datenspeicherung

## Firebase

Die App verwendet **Firebase Authentication** für die Benutzeranmeldung und **Cloud Firestore** für die dauerhafte Speicherung der Lernzeiteinträge.

Die Daten werden dem jeweils angemeldeten Benutzer zugeordnet. In Firestore werden die Lernzeiteinträge mit den benötigten Informationen wie Titel, Beschreibung und weiteren Angaben zur Lernzeit gespeichert. Jeder Benutzer sieht nur seine eigenen Lernzeiteinträge.


## Datenverwaltung

Die Lernzeitverwaltung ist vollständig mit Cloud Firestore verbunden.

Neue Lernzeiteinträge werden direkt in Firestore gespeichert. Bereits vorhandene Einträge werden beim Öffnen der Übersicht aus der Datenbank geladen und angezeigt. Bestehende Lernzeiten können bearbeitet und aktualisiert werden. Nicht mehr benötigte Einträge können nach einer Bestätigung gelöscht werden.

Änderungen werden direkt in der App sichtbar, sodass die angezeigten Daten immer dem aktuellen Stand in Firestore entsprechen.

## Weiterentwicklung

Die ursprüngliche Version der App basierte auf einer grundlegenden Navigation sowie einer Listen- und Detailansicht mit Mockup-Daten.

Die erste Version arbeitete mit Mock-Daten. In der aktuellen Version werden die Lernzeiten in Firestore gespeichert. Zusätzlich wurden Login, benutzerbezogene Daten, CRUD-Funktionen und Validierungen umgesetzt.

Zusätzlich wurden Firebase Authentication, benutzerbezogene Datenspeicherung, vollständige CRUD-Funktionen, Eingabevalidierung sowie Lade-, Leer- und Fehlerzustände integriert.

## Technologien

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore

## Ausblick

Als nächste Erweiterung könnte eine Statistik eingebaut werden. Damit könnten Lernzeiten pro Tag, Woche oder Monat ausgewertet werden. Zusätzlich wären persönliche Lernziele möglich.


## Projektstruktur Übersicht

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
    ├── lernzeit_tracker/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── info/
    │   └── presentation/
    │
    └── profile/
        └── presentation/