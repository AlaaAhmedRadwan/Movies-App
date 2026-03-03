import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/features/home/domain/entities/movie.dart';
import 'package:movies_app/features/home/presentation/widget/MoviePosterSection.dart';
import 'package:movies_app/features/home/presentation/widget/MovieSummarySection.dart';
import 'package:movies_app/features/home/presentation/widget/SimilarMoviesSection.dart';

import '../widget/MovieScreenshotsSection.dart';

class Moviedetails extends StatelessWidget {
  final Movie movie;
   Moviedetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.PrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
         Moviepostersection(posterUrl: movie.poster,
             rating: movie.rating, title: movie.title,
             runtime: movie.runtime, year: movie.year,likes: 10,),
            SizedBox(height: 16.h),
            MovieScreenshotsSection(),
            SizedBox(height: 16.h),
            SimilarMoviesSection(),
            SizedBox(height: 16.h),
           MovieSummarySection(summary: movie.summary)
        ],),

      ),
    );
  }
}
