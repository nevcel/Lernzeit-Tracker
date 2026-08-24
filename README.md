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

Die Daten werden dem jeweils angemeldeten Benutzer zugeordnet. In Firestore werden die Lernzeiteinträge mit den benötigten Informationen wie Titel, Beschreibung und weiteren Angaben zur Lernzeit gespeichert.

Dadurch besitzt jeder Benutzer seinen eigenen persönlichen Datenbereich.

## Datenverwaltung

Die Lernzeitverwaltung ist vollständig mit Cloud Firestore verbunden.

Neue Lernzeiteinträge werden direkt in Firestore gespeichert. Bereits vorhandene Einträge werden beim Öffnen der Übersicht aus der Datenbank geladen und angezeigt. Bestehende Lernzeiten können bearbeitet und aktualisiert werden. Nicht mehr benötigte Einträge können nach einer Bestätigung gelöscht werden.

Änderungen werden direkt in der App sichtbar, sodass die angezeigten Daten immer dem aktuellen Stand in Firestore entsprechen.

## Weiterentwicklung

Die ursprüngliche Version der App basierte auf einer grundlegenden Navigation sowie einer Listen- und Detailansicht mit Mockup-Daten.

Diese Grundlage wurde zu einer datenbankgestützten Anwendung weiterentwickelt. Die bisherigen Beispieldaten wurden durch dauerhaft gespeicherte Firestore-Daten ersetzt.

Zusätzlich wurden Firebase Authentication, benutzerbezogene Datenspeicherung, vollständige CRUD-Funktionen, Eingabevalidierung sowie Lade-, Leer- und Fehlerzustände integriert.

## Technologien

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore

## Ausblick

Als nächste Erweiterung bietet sich eine **Statistik- und Auswertungsfunktion** an. Die bereits gespeicherten Lernzeiten könnten beispielsweise nach Tagen, Wochen oder Monaten ausgewertet werden.

Zusätzlich könnten persönliche Lernziele definiert und deren Fortschritt dargestellt werden. Dadurch würde die App neben der Erfassung von Lernzeiten auch eine langfristige Übersicht über das eigene Lernverhalten ermöglichen.


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