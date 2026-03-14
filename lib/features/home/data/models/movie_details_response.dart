import 'package:movies_app/model/Castmodel.dart';

import '../../domain/entities/movie_details.dart';
import 'movie_model.dart';

class MovieDetailsModel extends MovieModel {
  final int? likeCount;
  final String? descriptionIntro;
  final String? mediumScreenshot1;
  final String? mediumScreenshot2;
  final String? mediumScreenshot3;
  final List<Castmodel> cast;

  MovieDetailsModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required super.poster,
    required super.genres,
    required super.summary,
    required super.runtime,
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
    this.likeCount,
    this.descriptionIntro,
    this.mediumScreenshot1,
    this.mediumScreenshot2,
    this.mediumScreenshot3,
    this.cast = const [],
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final rawTorrents = (json['torrents'] as List<dynamic>?)
        ?.map((e) => Torrents.fromJson(e as Map<String, dynamic>))
        .toList();

    final rawCast = (json['cast'] as List<dynamic>?)
        ?.map((e) => Castmodel(
              name: e['name'] as String? ?? '',
              character: e['character_name'] as String? ?? '',
              image: e['url_small_image'] as String? ?? '',
            ))
        .toList() ?? [];

    return MovieDetailsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      year: (json['year'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      runtime: (json['runtime'] as num).toInt(),
      genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      summary: (json['description_full'] as String?) ?? (json['summary'] as String? ?? ''),
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
      likeCount: (json['like_count'] as num?)?.toInt(),
      descriptionIntro: json['description_intro'] as String?,
      mediumScreenshot1: json['medium_screenshot_image1'] as String?,
      mediumScreenshot2: json['medium_screenshot_image2'] as String?,
      mediumScreenshot3: json['medium_screenshot_image3'] as String?,
      cast: rawCast,
    );
  }

  MovieDetails toEntity() => MovieDetails(
        id: id,
        title: title,
        year: year,
        rating: rating,
        poster: poster,
        genres: genres,
        summary: summary,
        runtime: runtime,
        torrents: torrents,
        url: url,
        imdbCode: imdbCode,
        titleEnglish: titleEnglish,
        titleLong: titleLong,
        slug: slug,
        descriptionFull: descriptionFull,
        synopsis: synopsis,
        ytTrailerCode: ytTrailerCode,
        language: language,
        mpaRating: mpaRating,
        backgroundImage: backgroundImage,
        backgroundImageOriginal: backgroundImageOriginal,
        smallCoverImage: smallCoverImage,
        largeCoverImage: largeCoverImage,
        state: state,
        dateUploaded: dateUploaded,
        dateUploadedUnix: dateUploadedUnix,
        likeCount: likeCount,
        descriptionIntro: descriptionIntro,
        mediumScreenshot1: mediumScreenshot1,
        mediumScreenshot2: mediumScreenshot2,
        mediumScreenshot3: mediumScreenshot3,
        cast: cast,
      );
}

class MovieDetailsResponse {
  final String? status;
  final MovieDetailsModel? movie;

  MovieDetailsResponse({this.status, this.movie});

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailsResponse(
        status: json['status'] as String?,
        movie: json['data']?['movie'] != null
            ? MovieDetailsModel.fromJson(
                json['data']['movie'] as Map<String, dynamic>)
            : null,
      );
}
