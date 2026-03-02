import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class Torrents {
  final String? url;
  final String? hash;
  final String? quality;
  final String? size;

  Torrents({this.url, this.hash, this.quality, this.size});

  factory Torrents.fromJson(Map<String, dynamic> json) =>
      _$TorrentsFromJson(json);
}

@JsonSerializable()
class MovieModel extends Movie {
  @JsonKey(name: 'medium_cover_image')
  final String poster;

  final List<Torrents>? torrents;

  MovieModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required this.poster,
    required super.genres,
    required super.summary,
    required super.runtime,
    this.torrents,
  }) : super(poster: poster);

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}