import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isEnglish = locale.languageCode == 'en';

    return Container(
      width: 90.w,
      height: 38.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        border: Border.all(
          color: const Color(0xFFFFC107),
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _languageItem(
            isSelected: isEnglish,
            flagPath: 'assets/images/usa_ic.png',
            onTap: () async {
              await context.setLocale(const Locale('en'));

            },
          ),
          _languageItem(
            isSelected: !isEnglish,
            flagPath: 'assets/images/eg_ic.png',
            onTap: () async {
              await context.setLocale(const Locale('ar'));
            },
          ),
        ],
      ),
    );
  }

  Widget _languageItem({
    required bool isSelected,
    required String flagPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: isSelected ? EdgeInsets.zero : EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
            color: const Color(0xFFFFC107),
            width: 4,
          )
              : null,
        ),
        child: ClipOval(
          child: Image.asset(
            flagPath,
            width: 27.w,
            height: 27.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}