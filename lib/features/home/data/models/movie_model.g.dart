// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Torrents _$TorrentsFromJson(Map<String, dynamic> json) => Torrents(
  url: json['url'] as String?,
  hash: json['hash'] as String?,
  quality: json['quality'] as String?,
  size: json['size'] as String?,
);

Map<String, dynamic> _$TorrentsToJson(Torrents instance) => <String, dynamic>{
  'url': instance.url,
  'hash': instance.hash,
  'quality': instance.quality,
  'size': instance.size,
};

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  year: (json['year'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  poster: json['medium_cover_image'] as String,
  genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
  summary: json['summary'] as String,
  runtime: (json['runtime'] as num).toInt(),
  torrents: (json['torrents'] as List<dynamic>?)
      ?.map((e) => Torrents.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'year': instance.year,
      'rating': instance.rating,
      'genres': instance.genres,
      'summary': instance.summary,
      'runtime': instance.runtime,
      'medium_cover_image': instance.poster,
      'torrents': instance.torrents,
    };
