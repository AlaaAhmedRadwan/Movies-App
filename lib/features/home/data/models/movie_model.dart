import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Movie {
  @JsonKey(name: 'medium_cover_image')
  final String poster;

  MovieModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required this.poster,
    required super.genres,
    required super.summary,
    required super.runtime,
  }) : super(poster: poster);

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}