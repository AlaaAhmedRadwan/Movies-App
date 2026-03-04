import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';

class MovieSummarySection extends StatelessWidget {
  final String summary;

  const MovieSummarySection({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.summary.tr(),
            style: TextStyle(
              color: ColorsManager.SecondaryColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 8.h),
          Text(
            summary,
            style: TextStyle(
              color: ColorsManager.SecondaryColor,
              fontSize: 16.sp,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}