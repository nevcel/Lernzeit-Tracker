class LernzeitSession {
  // Titel der Lernsession
  final String title;

  // Beschreibung der Lerninhalte
  final String description;

  // Dauer der Lernsession in Minuten
  final int durationMinutes;

  // Fach oder Thema der Lernsession
  final String subject;

  const LernzeitSession({
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.subject,
  });
}