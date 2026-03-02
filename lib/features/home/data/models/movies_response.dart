import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class MovieResponse {
  final String? status;

  @JsonKey(name: 'status_message')
  final String? statusMessage;

  final Data? data;

  MovieResponse({this.status, this.statusMessage, this.data});

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'movie_count')
  final int? movieCount;

  final int? limit;

  @JsonKey(name: 'page_number')
  final int? pageNumber;

  final List<MovieModel>? movies;

  Data({this.movieCount, this.limit, this.pageNumber, this.movies});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}