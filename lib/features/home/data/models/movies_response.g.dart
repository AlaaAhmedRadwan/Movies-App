// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      status: json['status'] as String?,
      statusMessage: json['status_message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  movieCount: (json['movie_count'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  pageNumber: (json['page_number'] as num?)?.toInt(),
  movies: (json['movies'] as List<dynamic>?)
      ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);
