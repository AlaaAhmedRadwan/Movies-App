import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class MoviesResponse {
  final DataResponse data;

  MoviesResponse({required this.data});

  factory MoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseFromJson(json);
}

@JsonSerializable()
class DataResponse {
  final List<MovieModel> movies;

  DataResponse({required this.movies});

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);
}