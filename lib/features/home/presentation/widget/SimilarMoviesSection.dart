import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import 'package:movies_app/core/routing/app_router.dart';
import 'package:movies_app/features/home/domain/entities/movie.dart';

import 'SimilarMovieItem.dart';

class SimilarMoviesSection extends StatelessWidget {
  final List<Movie> movies;

  const SimilarMoviesSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            StringsManager.similar.tr(),
            style: const TextStyle(
              color: ColorsManager.SecondaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => context.push(AppRouter.movieDetails, extra: movie),
                child: SimilarMovieItem(
                  imageUrl: movie.poster,
                  rating: movie.rating,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
