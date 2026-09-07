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

  // Daten in ein LernzeitSession-Objekt umwandeln
  factory LernzeitSession.fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    return LernzeitSession(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      subject: data['subject'] ?? '',
      durationSeconds: (data['durationSeconds'] as num?)?.toInt() ?? 0,
    );
  }

  // LernzeitSession für die Speicherung vorbereiten
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'durationSeconds': durationSeconds,
    };
  }

  // Sekunden werden für die Anzeige formatiert
  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    final seconds = durationSeconds % 60;

    return '${hours}h ${minutes}min ${seconds}s';
  }
}