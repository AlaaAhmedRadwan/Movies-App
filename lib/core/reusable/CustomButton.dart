import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/ColorsManager.dart';

class CustomButton extends StatelessWidget {
  String title;
  void Function() onClick;
  final Color backgroundColor;
  final Color textColor;

  CustomButton({required this.title,required this.onClick,
    this.backgroundColor=ColorsManager.onPrimaryColor,
    this.textColor=ColorsManager.PrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
      ),
      child: ElevatedButton(
          onPressed: onClick,

          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorsManager.onPrimaryColor),
              borderRadius: BorderRadius.circular(16)
            ),

          ),
          child: Text(title,
            textAlign: TextAlign.center,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor
          ),)
      ),
    );
  }
}
