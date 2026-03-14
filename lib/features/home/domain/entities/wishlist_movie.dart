class WishlistMovie {
  final int id;
  final String title;
  final String poster;
  final int year;

  const WishlistMovie({
    required this.id,
    required this.title,
    required this.poster,
    required this.year,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'poster': poster,
        'year': year,
      };

  factory WishlistMovie.fromMap(Map<String, dynamic> map) => WishlistMovie(
        id: (map['id'] as num).toInt(),
        title: map['title'] as String,
        poster: map['poster'] as String,
        year: (map['year'] as num).toInt(),
      );
}
