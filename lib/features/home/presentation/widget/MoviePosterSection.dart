
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import 'package:movies_app/core/reusable/CustomButton.dart';
import 'package:movies_app/features/home/domain/entities/movie_torrent.dart';
import 'package:movies_app/features/home/presentation/screen/TorrentPlayerScreen.dart';
import 'package:movies_app/features/home/presentation/widget/MovieStateItem.dart';

import '../../../../core/resources/ColorsManager.dart';
class Moviepostersection extends StatelessWidget {
  String posterUrl;
  String title;
  int year;
  int runtime;
  double rating;
   int likes;
  final List<MovieTorrent> torrents;

   Moviepostersection({required this.posterUrl,required this.rating,
   required this.title,required this.runtime,
   required this.year,required this.likes,
   this.torrents = const []});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
          alignment: Alignment.center,
      children:
        [
        CachedNetworkImage(
          imageUrl: posterUrl,
          fit: BoxFit.cover,
          height: 645.h,
           width:  430.w,
          placeholder: (context, url) =>
         Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              Container(color: Colors.grey),
        ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,],),),),),
    Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             IconButton(
                 onPressed: () {
                 Navigator.pop(context);
                },
                    icon: Icon(
                Icons.arrow_back,
              color: ColorsManager.SecondaryColor,),),
              IconButton(onPressed: () {

              }, icon:Icon(Icons.bookmark),color: ColorsManager.SecondaryColor,)
            ],),
          Image.asset(Assetsmanager.watchbutton),
          Text(title.tr(),textAlign:TextAlign.center,style:
            TextStyle(color: ColorsManager.SecondaryColor,
            fontSize: 24,
            fontWeight:FontWeight.w700),),
          SizedBox(height: 15.h,),
          Text(year.toString(),textAlign:TextAlign.center,style:
          TextStyle(color: Color(0xffADADAD),
              fontSize: 20,
              fontWeight:FontWeight.w700),),
            SizedBox(height: 8.h,),
          
            CustomButton(title: StringsManager.watch.tr(), onClick: () {
              if (torrents.isEmpty) return;
              _showQualityPicker(context);
            },backgroundColor: ColorsManager.teritaryColor,
            textColor: ColorsManager.SecondaryColor,),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Moviestateitem(icon: Icons.favorite_rounded, value:likes.toString() ),
                Moviestateitem(icon: Icons.access_time_filled_rounded, value:runtime.toString() ),
                Moviestateitem(icon: Icons.star_outlined, value:rating.toString() ),

              ],
            ),
        ])
    )])
          );
   }

  void _showQualityPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.PrimaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Select Quality',
                style: TextStyle(
                  color: ColorsManager.SecondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...torrents.map((t) => ListTile(
                  title: Text(
                    '${t.quality} · ${t.type.toUpperCase()}',
                    style: TextStyle(color: ColorsManager.SecondaryColor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TorrentPlayerScreen(
                          magnetLink: t.magnetLink(title),
                          title: title,
                        ),
                      ),
                    );
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
