class HistoryMovie {
  final int id;
  final String title;
  final String poster;
  final DateTime watchedAt;

  const HistoryMovie({
    required this.id,
    required this.title,
    required this.poster,
    required this.watchedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'poster': poster,
        'watchedAt': watchedAt.toIso8601String(),
      };

  factory HistoryMovie.fromMap(Map<String, dynamic> map) => HistoryMovie(
        id: (map['id'] as num).toInt(),
        title: map['title'] as String,
        poster: map['poster'] as String,
        watchedAt: DateTime.parse(map['watchedAt'] as String),
      );
}
