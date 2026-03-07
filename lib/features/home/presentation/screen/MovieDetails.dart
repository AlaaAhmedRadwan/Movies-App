import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/di/get_it.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/features/home/domain/entities/movie.dart';
import 'package:movies_app/features/home/presentation/cubit/movie_details_cubit.dart';
import 'package:movies_app/features/home/presentation/cubit/movie_details_state.dart';
import 'package:movies_app/features/home/presentation/widget/MovieCastSection.dart';
import 'package:movies_app/features/home/presentation/widget/MovieGenresSection.dart';
import 'package:movies_app/features/home/presentation/widget/MoviePosterSection.dart';
import 'package:movies_app/features/home/presentation/widget/MovieScreenshotsSection.dart';
import 'package:movies_app/features/home/presentation/widget/MovieSummarySection.dart';
import 'package:movies_app/features/home/presentation/widget/SimilarMoviesSection.dart';

class Moviedetails extends StatelessWidget {
  final Movie movie;

  const Moviedetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieDetailsCubit>()..getDetails(movie.id),
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
                    posterUrl: movie.poster,
                    rating: movie.rating,

                    title: movie.title,
                    runtime: movie.runtime,
                    year: movie.year,
                    likes: state is MovieDetailsLoaded ? (state.details.likeCount ?? 0) : 0,
                    torrents: movie.torrents,
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
                  MovieSummarySection(summary: movie.summary),
                  Moviecastsection(),
                  MovieGenresSection(genres: movie.genres),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
