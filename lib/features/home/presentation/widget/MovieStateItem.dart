import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';

class Moviestateitem extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final String value;
  const Moviestateitem({required this.icon,required this.value,
    this.iconColor=ColorsManager.onPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 11,
        horizontal: 21,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.onSecondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon,color: iconColor,),
          SizedBox(
            width: 3.w,
          ),
          Text(value,style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: ColorsManager.SecondaryColor
          ),)
        ],
      ),
    );
  }
}
