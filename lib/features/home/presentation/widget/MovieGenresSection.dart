import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/ColorsManager.dart';
import '../../../../core/resources/StringsManager.dart';
import 'GenreItem.dart';

class MovieGenresSection extends StatelessWidget {

  final List<String> genres;

  MovieGenresSection({ required this.genres});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.genres.tr(),
          style: TextStyle(
            color: ColorsManager.SecondaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 12.h),

        Wrap(
          spacing: 16.w,
          runSpacing: 10.h,
          children: genres.map((genre) {
            return GenreItem(genre: genre);
          }).toList(),
        )

      ],
    );
  }
}