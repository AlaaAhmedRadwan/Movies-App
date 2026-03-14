import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/di/get_it.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/features/home/data/services/firebase_movies_service.dart';
import 'package:movies_app/features/home/domain/entities/history_movie.dart';
import 'package:movies_app/features/home/domain/entities/movie.dart';
import 'package:movies_app/features/home/presentation/cubit/movie_details_cubit.dart';
import 'package:movies_app/features/home/presentation/cubit/movie_details_state.dart';
import 'package:movies_app/features/home/presentation/widget/MovieCastSection.dart';
import 'package:movies_app/features/home/presentation/widget/MovieGenresSection.dart';
import 'package:movies_app/features/home/presentation/widget/MoviePosterSection.dart';
import 'package:movies_app/features/home/presentation/widget/MovieScreenshotsSection.dart';
import 'package:movies_app/features/home/presentation/widget/MovieSummarySection.dart';
import 'package:movies_app/features/home/presentation/widget/SimilarMoviesSection.dart';

class Moviedetails extends StatefulWidget {
  final Movie movie;

  const Moviedetails({super.key, required this.movie});

  @override
  State<Moviedetails> createState() => _MoviedetailsState();
}

class _MoviedetailsState extends State<Moviedetails> {
  @override
  void initState() {
    super.initState();
    _addToHistory();
  }

  Future<void> _addToHistory() async {
    try {
      await sl<FirebaseMoviesService>().addToHistory(HistoryMovie(
        id: widget.movie.id,
        title: widget.movie.title,
        poster: widget.movie.poster,
        watchedAt: DateTime.now(),
      ));
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieDetailsCubit>()..getDetails(widget.movie.id),
      child: Scaffold(
        backgroundColor: ColorsManager.PrimaryColor,
        body: SingleChildScrollView(
          child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
            builder: (context, state) {
              final screenshots = state is MovieDetailsLoaded
                  ? state.details.screenshots
                  : <String>[];

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Moviepostersection(
                    posterUrl: widget.movie.poster,
                    rating: widget.movie.rating,
                    title: widget.movie.title,
                    runtime: widget.movie.runtime,
                    year: widget.movie.year,
                    likes: state is MovieDetailsLoaded
                        ? (state.details.likeCount ?? 0)
                        : 0,
                    torrents: widget.movie.torrents,
                    movieId: widget.movie.id,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(height: 16.h),
                  if (state is MovieDetailsLoading)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    )
                  else
                    MovieScreenshotsSection(screenshots: screenshots),
                  SizedBox(height: 16.h),
                  SimilarMoviesSection(),
                  SizedBox(height: 16.h),
                  MovieSummarySection(summary: widget.movie.summary),
                  Moviecastsection(),
                  MovieGenresSection(genres: widget.movie.genres),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
