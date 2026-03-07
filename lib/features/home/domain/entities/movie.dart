import 'movie_torrent.dart';

class Movie {
  final int id;
  final String? url;
  final String? imdbCode;
  final String title;
  final String? titleEnglish;
  final String? titleLong;
  final String? slug;
  final int year;
  final int? like_count;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String? descriptionFull;
  final String? synopsis;
  final String? ytTrailerCode;
  final String? language;
  final String? mpaRating;
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String? smallCoverImage;
  final String poster;
  final String? largeCoverImage;
  final String? state;
  final String? dateUploaded;
  final int? dateUploadedUnix;
  final List<MovieTorrent> torrents;

  Movie({
    required this.id,
    this.url,
    this.like_count,
    this.imdbCode,
    required this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    required this.poster,
    this.largeCoverImage,
    this.state,
    this.dateUploaded,
    this.dateUploadedUnix,
    this.torrents = const [],
  });
}
