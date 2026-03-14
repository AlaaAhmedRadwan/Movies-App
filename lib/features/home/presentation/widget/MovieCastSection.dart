import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/home/presentation/widget/CastItem.dart';

import '../../../../core/resources/ColorsManager.dart';
import '../../../../core/resources/StringsManager.dart';
import '../../../../model/Castmodel.dart';

class Moviecastsection extends StatelessWidget {
  final List<Castmodel> cast;

  const Moviecastsection({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.cast.tr(),
            style: const TextStyle(
              color: ColorsManager.SecondaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 9.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cast.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Castitem(cast: cast[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
