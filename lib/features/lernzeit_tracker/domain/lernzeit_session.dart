class LernzeitSession {
  final String id;
  final String title;
  final String description;
  final int durationSeconds;
  final String subject;

  const LernzeitSession({
    this.id = '',
    required this.title,
    required this.description,
    required this.durationSeconds,
    required this.subject,
  });

  // Sekunden werden für die Anzeige formatiert
  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    final seconds = durationSeconds % 60;

    return '${hours}h ${minutes}min ${seconds}s';
  }
}