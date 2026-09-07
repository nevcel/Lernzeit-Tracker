# Lernzeit Tracker

Der **Lernzeit Tracker** ist eine mit Flutter entwickelte App zur strukturierten Erfassung und Verwaltung persönlicher Lernzeiten.

Benutzerinnen und Benutzer können ihre Lernzeit mit einem integrierten Timer erfassen, Lerneinträge speichern, anzeigen, bearbeiten und löschen. Die Daten werden benutzerbezogen in Cloud Firestore gespeichert.

## Funktionen

- Registrierung und Anmeldung mit E-Mail und Passwort
- Sichere Abmeldung
- Persönliche Lernzeiten mit integriertem Timer erfassen
- Lernzeiteinträge speichern und anzeigen
- Bestehende Einträge bearbeiten
- Einträge nach einer Sicherheitsabfrage löschen
- Eingabevalidierung und verständliche Fehlermeldungen
- Lade-, Leer- und Fehlerzustände
- Benutzerbezogene Datenspeicherung
- Welcome-Screen beim ersten App-Start
- Persönlicher Profilbereich
- Motivierende Erfolgsmeldung nach einer abgeschlossenen Lernsession
- Eigenes App-Logo, Launcher Icon und Splash Screen

## Authentication

Die Benutzerverwaltung erfolgt über **Firebase Authentication**.

Die Authentication unterstützt:

- Registrierung mit E-Mail und Passwort
- Anmeldung bestehender Benutzer
- Abmeldung
- Validierung der Eingaben
- verständliche Fehlermeldungen bei fehlgeschlagenen Anmeldungen
- Behandlung von Netzwerk- und Firebase-Fehlern
- Ladezustände während der Anmeldung und Abmeldung

Die Firebase-Authentication-Zugriffe sind zentral im `AuthService` umgesetzt und dadurch von der Benutzeroberfläche getrennt.

```text
lib/features/lernzeit_tracker/data/auth_service.dart
```

## Firebase und CRUD

Die Lernzeiteinträge werden dauerhaft in **Cloud Firestore** gespeichert.

Die Daten werden dem aktuell angemeldeten Benutzer zugeordnet. Dadurch besitzt jeder Benutzer seinen eigenen Bereich mit persönlichen Lernzeiteinträgen.

Die Firestore-Struktur ist grundsätzlich wie folgt aufgebaut:

```text
users/
└── userId/
    └── lernzeit_tracker_collection/
        └── documentId
            ├── title
            ├── subject
            ├── description
            └── durationSeconds
```

Die App unterstützt alle CRUD-Funktionen:

- **Create:** Neue Lernzeiten werden nach dem Erfassen in Firestore gespeichert.
- **Read:** Gespeicherte Lernzeiten werden aus Firestore geladen und in der Übersicht angezeigt.
- **Update:** Bestehende Lernzeiten können bearbeitet und in Firestore aktualisiert werden.
- **Delete:** Lernzeiten können nach einer Sicherheitsabfrage gelöscht werden.

Die Firestore-Zugriffe sind zentral umgesetzt in:

```text
lib/features/lernzeit_tracker/data/lernzeit_firestore.dart
```

Das Mapping zwischen Firestore-Daten und dem Datenmodell erfolgt zentral mit `fromMap()` und `toMap()` in:

```text
lib/features/lernzeit_tracker/domain/lernzeit_session.dart
```

## Benutzerfreundlichkeit

Für Erstnutzer wird beim ersten Start der App ein kurzer Welcome-Screen angezeigt. Dieser erklärt die wichtigsten Funktionen des Lernzeit Trackers.

Mit `shared_preferences` wird lokal gespeichert, ob der Welcome-Screen bereits abgeschlossen wurde. Dadurch wird die Einführung nur beim ersten Start angezeigt.

Nach dem erfolgreichen Speichern einer Lernsession erscheint zusätzlich eine motivierende Erfolgsmeldung. Die Meldung passt sich an die Dauer der abgeschlossenen Lernsession an.

Beispiele:

- Kleine Schritte zählen! 🌱
- Gute Session! Weiter so. 💪
- Starke Leistung! 🔥
- Wow – richtig starke Lernsession! 🏆

## Fehlerbehandlung und Verbesserungen

Im Verlauf der Entwicklung wurden verschiedene technische und funktionale Bereiche überarbeitet.

Insbesondere wurden folgende Punkte verbessert:

- Fehlerbehandlung bei Create, Update und Delete ergänzt
- mögliche dauerhafte `Speichern...`-Zustände durch `try`, `catch` und `finally` verhindert
- verständliche Fehlermeldungen für Firebase Authentication ergänzt
- Firebase-Zugriffe aus den UI-Screens ausgelagert
- Authentication in einen eigenen `AuthService` ausgelagert
- Firestore-Mapping zentralisiert
- duplizierte Mapping-Logik reduziert
- Firestore Security Rules in die Projektabgabe aufgenommen
- nicht mehr benötigter und auskommentierter Code entfernt
- Platzhaltertexte und unfertige Bereiche entfernt
- Profilbereich erweitert
- Navigation mit `IndexedStack` verbessert
- Detailansicht für kleinere Smartphone-Displays optimiert
- zentrales App-Theme für ein konsistentes Erscheinungsbild eingeführt
- Lade-, Leer- und Fehlerzustände überprüft und verbessert

Der aktuelle Code wurde mit

```bash
flutter analyze
```

überprüft.

Ergebnis:

```text
No issues found!
```

## Refactoring und Codequalität

Die App wurde so refaktoriert, dass Benutzeroberfläche, Datenzugriff und Datenmodell klarer voneinander getrennt sind.

Die wichtigsten Verantwortlichkeiten sind aufgeteilt in:

```text
Presentation
    ↓
Data / Services
    ↓
Firebase
```

Dadurch befinden sich direkte Firebase-Zugriffe nicht mehr in den UI-Screens.

Zusätzlich wurden wiederholte Datenkonvertierungen durch zentrale Methoden im Datenmodell reduziert.

## Packages

### flutter_svg

Das Package `flutter_svg` wird verwendet, um das eigene SVG-Logo der App darzustellen.

Installation:

```bash
flutter pub add flutter_svg
```

Das Logo befindet sich unter:

```text
assets/images/lernzeit_logo.svg
```

und wird unter anderem im Info-Bereich und Welcome-Screen verwendet.

Beispiel:

```dart
SvgPicture.asset(
  'assets/images/lernzeit_logo.svg',
)
```

### shared_preferences

Das Package `shared_preferences` wird verwendet, um lokal zu speichern, ob der Welcome-Screen bereits abgeschlossen wurde.

Dadurch wird das Onboarding nur beim ersten Start der App angezeigt.

Installation:

```bash
flutter pub add shared_preferences
```

### flutter_launcher_icons

Für das eigene Launcher Icon wurde `flutter_launcher_icons` verwendet.

```bash
flutter pub add --dev flutter_launcher_icons
```

Als Grundlage dient:

```text
assets/images/lernzeit_logo.png
```

### flutter_native_splash

Für den eigenen Splash Screen wurde `flutter_native_splash` verwendet.

Der Splash Screen verwendet die Farbgestaltung und das Logo des Lernzeit Trackers und wird beim Start der App angezeigt.

## Assets

Die eigenen Assets befinden sich unter:

```text
assets/
└── images/
    ├── lernzeit_logo.svg
    └── lernzeit_logo.png
```

Der Asset-Ordner ist in der `pubspec.yaml` registriert:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

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
    ├── lernzeit_tracker/
    │   ├── data/
    │   │   ├── auth_service.dart
    │   │   └── lernzeit_firestore.dart
    │   │
    │   ├── domain/
    │   │   └── lernzeit_session.dart
    │   │
    │   └── presentation/
    │       ├── auth_screen.dart
    │       ├── welcome_screen.dart
    │       ├── lernzeit_add_screen.dart
    │       ├── lernzeit_detail_screen.dart
    │       ├── lernzeit_edit_screen.dart
    │       └── lernzeit_list_screen.dart
    │
    ├── info/
    │   └── presentation/
    │       └── info_screen.dart
    │
    └── profile/
        └── presentation/
            └── profile_screen.dart

assets/
└── images/
    ├── lernzeit_logo.svg
    └── lernzeit_logo.png

firestore.rules
pubspec.yaml
pubspec.lock
```

## Store-Ready-Zustand

Für einen möglichst vollständigen und professionellen Gesamtzustand wurden folgende Punkte umgesetzt:

- eigenes Launcher Icon
- eigener Splash Screen
- eigenes App-Logo
- Welcome-Screen für Erstnutzer
- konsistentes App-Theme
- responsive Darstellung für kleinere Smartphones
- keine offensichtlichen Platzhalter oder Testelemente
- benutzerfreundliche Fehler- und Ladezustände
- sichere Löschbestätigung
- Authentication
- benutzerbezogene Cloud-Datenspeicherung
- vollständiges Firebase CRUD

## Test

Die zentralen Abläufe wurden praktisch getestet:

```text
App starten
→ Welcome-Screen
→ Registrierung / Login
→ Lernsession starten
→ Timer stoppen
→ Lernzeit speichern
→ Erfolgsmeldung
→ Eintrag anzeigen
→ Eintrag bearbeiten
→ Änderung kontrollieren
→ Eintrag löschen
→ Löschung bestätigen
→ Profil öffnen
→ Logout
→ erneut einloggen
```

Zusätzlich wurde der Code mit `flutter analyze` überprüft.

## Ausblick

Eine sinnvolle zukünftige Erweiterung wäre eine Statistik- und Auswertungsfunktion.

Denkbar wären beispielsweise:

- Lernzeit pro Tag
- Wochen- und Monatsauswertungen
- persönliche Lernziele
- Fortschrittsanzeigen
- Lernserien bzw. Streaks
- Kategorien für verschiedene Lernbereiche

Dadurch könnte der Lernzeit Tracker neben der Erfassung von Lernzeiten zukünftig auch die langfristige Entwicklung des persönlichen Lernverhaltens darstellen.