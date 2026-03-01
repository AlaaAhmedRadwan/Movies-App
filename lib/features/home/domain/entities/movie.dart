class Movie {
  final int id;
  final String title;
  final int year;
  final double rating;
  final String poster;
  final List<String> genres;
  final String summary;
  final int runtime;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.poster,
    required this.genres,
    required this.summary,
    required this.runtime,
  });
}