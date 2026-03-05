import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import '../../../../core/resources/ColorsManager.dart';

class GenreItem extends StatelessWidget {
  final String genre;

  const GenreItem({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.onSecondaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        StringsManager.genres.tr(),
        style: TextStyle(
          color: ColorsManager.SecondaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}