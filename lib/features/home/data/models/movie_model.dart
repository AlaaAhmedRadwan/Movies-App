import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_torrent.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class Torrents {
  final String? url;
  final String? hash;
  final String? quality;
  final String? type;
  @JsonKey(name: 'is_repack')
  final String? isRepack;
  @JsonKey(name: 'video_codec')
  final String? videoCodec;
  @JsonKey(name: 'bit_depth')
  final String? bitDepth;
  @JsonKey(name: 'audio_channels')
  final String? audioChannels;
  final int? seeds;
  final int? peers;
  final int? like_count;
  final String? size;
  @JsonKey(name: 'size_bytes')
  final int? sizeBytes;
  @JsonKey(name: 'date_uploaded')
  final String? dateUploaded;
  @JsonKey(name: 'date_uploaded_unix')
  final int? dateUploadedUnix;

  Torrents({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
    this.like_count,
  });

  factory Torrents.fromJson(Map<String, dynamic> json) =>
      _$TorrentsFromJson(json);

  MovieTorrent toEntity() => MovieTorrent(
        hash: hash ?? '',
        quality: quality ?? '',
        type: type ?? '',
      );
}

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.genres,
    required super.summary,

    required super.poster,
    super.url,
    super.imdbCode,
    super.titleEnglish,
    super.titleLong,
    super.slug,
    super.descriptionFull,
    super.synopsis,
    super.ytTrailerCode,
    super.language,
    super.mpaRating,
    super.backgroundImage,
    super.backgroundImageOriginal,
    super.smallCoverImage,
    super.largeCoverImage,
    super.state,
    super.dateUploaded,
    super.dateUploadedUnix,
    super.torrents,
    super.like_count
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final rawTorrents = (json['torrents'] as List<dynamic>?)
        ?.map((e) => Torrents.fromJson(e as Map<String, dynamic>))
        .toList();

    return MovieModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      year: (json['year'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      runtime: (json['runtime'] as num).toInt(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      like_count: (json['like_count'] as num?)?.toInt(),
      summary: json['summary'] as String,
      poster: json['medium_cover_image'] as String,
      url: json['url'] as String?,
      imdbCode: json['imdb_code'] as String?,
      titleEnglish: json['title_english'] as String?,
      titleLong: json['title_long'] as String?,
      slug: json['slug'] as String?,
      descriptionFull: json['description_full'] as String?,
      synopsis: json['synopsis'] as String?,
      ytTrailerCode: json['yt_trailer_code'] as String?,
      language: json['language'] as String?,
      mpaRating: json['mpa_rating'] as String?,
      backgroundImage: json['background_image'] as String?,
      backgroundImageOriginal: json['background_image_original'] as String?,
      smallCoverImage: json['small_cover_image'] as String?,
      largeCoverImage: json['large_cover_image'] as String?,
      state: json['state'] as String?,
      dateUploaded: json['date_uploaded'] as String?,
      dateUploadedUnix: (json['date_uploaded_unix'] as num?)?.toInt(),
      torrents: rawTorrents?.map((t) => t.toEntity()).toList() ?? [],
    );
  }
}
