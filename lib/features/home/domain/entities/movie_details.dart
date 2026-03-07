import 'movie.dart';

class MovieDetails extends Movie {
  final int? likeCount;
  final String? descriptionIntro;
  final String? mediumScreenshot1;
  final String? mediumScreenshot2;
  final String? mediumScreenshot3;

  List<String> get screenshots => [
        if (mediumScreenshot1 != null && mediumScreenshot1!.isNotEmpty)
          mediumScreenshot1!,
        if (mediumScreenshot2 != null && mediumScreenshot2!.isNotEmpty)
          mediumScreenshot2!,
        if (mediumScreenshot3 != null && mediumScreenshot3!.isNotEmpty)
          mediumScreenshot3!,
      ];

  MovieDetails({
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
  });
}
