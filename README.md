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

```

## Packages und Assets

Für die App wurde das Package `flutter_svg` verwendet.

Das Package wurde ausgewählt, weil es SVG-Dateien direkt in Flutter darstellen kann, gut dokumentiert ist und die benötigten Plattformen unterstützt. Zusätzlich eignet es sich gut für die Einbindung eines eigenen App-Logos.

Installiert wurde das Package mit:

```bash
flutter pub add flutter_svg
```

Das eigene SVG-Asset befindet sich unter:

```text
assets/images/lernzeit_logo.svg
```

Der Asset-Ordner wurde in der `pubspec.yaml` registriert:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

Im Dart-Code wird das Package mit folgendem Import verwendet:

```dart
import 'package:flutter_svg/flutter_svg.dart';
```

Das Logo wird im Info-Bereich der App mit `SvgPicture.asset()` eingebunden:

```dart
SvgPicture.asset(
  'assets/images/lernzeit_logo.svg',
  width: 140,
  height: 140,
)
```

### Angepasste Dateien

Für die Umsetzung wurden folgende Dateien angepasst beziehungsweise ergänzt:

```text
pubspec.yaml
pubspec.lock
lib/features/info/presentation/info_screen.dart
assets/images/lernzeit_logo.svg
```

### Test

Nach der Installation und Registrierung des Assets wurde ausgeführt:

```bash
flutter pub get
```

Anschliessend wurde die App gestartet und geprüft, ob das SVG-Logo im Info-Bereich korrekt angezeigt wird.

Das Package und das Asset funktionieren wie vorgesehen.

### Fehlerbehebung

Falls ein Package nicht gefunden oder ein Asset nicht angezeigt wird, werden die möglichen Fehler schrittweise überprüft:

- Eintrag des Packages in der `pubspec.yaml`
- korrekte YAML-Einrückung
- erfolgreiche Installation des Packages
- korrekter Import im Dart-Code
- korrekter Asset-Eintrag in der `pubspec.yaml`
- exakter Asset-Pfad
- Gross- und Kleinschreibung des Dateinamens
- Ausführen von `flutter pub get`
- Neustart der App nach Änderungen

Durch dieses Vorgehen können typische Fehler bei Packages, Imports und Assets systematisch gefunden und behoben werden.