import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';

import '../../../../model/Castmodel.dart';

class Castitem extends StatelessWidget {
  final Castmodel cast;

  Castitem({required this.cast});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
        padding:  EdgeInsets.all(11),
        decoration: BoxDecoration(
        color: ColorsManager.onSecondaryColor,
        borderRadius: BorderRadius.circular(16.r),
        ),

        child: Row(
             children: [
        ClipRRect(
           borderRadius: BorderRadius.circular(10),
         child:
         CachedNetworkImage(
           imageUrl: cast.image,
           width: 70.w,
           height: 70.h,
           fit: BoxFit.cover,
           placeholder: (context, url) =>
               SizedBox(
                 width: 70.w,
                 height: 70.h,
                 child: const Center(
                   child: CircularProgressIndicator(strokeWidth: 2),
                 ),
               ),
           errorWidget: (context, url, error) =>
           SizedBox(
               width: 70.w,
               height: 70.h,
               child: Center(
                   child: Icon(Icons.error, color: ColorsManager.teritaryColor))),
         ),),

         SizedBox(width: 5.w),
        Expanded(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
               children: [

             Text(
             "Name : ${cast.name}",
                style: TextStyle(
                   color: ColorsManager.SecondaryColor,
               fontSize: 20,
                  fontWeight: FontWeight.w400
           ),),

          Text(
          "Character : ${cast.character}",
              style: TextStyle(
              color: ColorsManager.SecondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w400
              ),
          ),
          ],
          ),
        )],
        ),
        ),
      ],
    );}}
