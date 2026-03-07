import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';

import 'SimilarMovieItem.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> movies = [
      {
        "image": "https://picsum.photos/200/300?1",
        "rating": 7.7,
      },
      {
        "image": "https://picsum.photos/200/300?2",
        "rating": 7.7,
      },
      {
        "image": "https://picsum.photos/200/300?3",
        "rating": 7.7,
      },
      {
        "image": "https://picsum.photos/200/300?4",
        "rating": 7.7,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.similar.tr(),
          style: TextStyle(
            color: ColorsManager.SecondaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 10.h),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics:  NeverScrollableScrollPhysics(),
            itemCount: movies.length,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return SimilarMovieItem(
                imageUrl: movies[index]["image"],
                rating: movies[index]["rating"],
              );
            },
          ),
        ),
      ],
    );
  }
}
