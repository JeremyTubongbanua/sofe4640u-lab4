class Note {
  final String title;
  final String description;

  Note({
    required this.title,
    required this.description,
  });

  Map<String, String> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Note.fromMap(Map<String, String> map) {
    return Note(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
