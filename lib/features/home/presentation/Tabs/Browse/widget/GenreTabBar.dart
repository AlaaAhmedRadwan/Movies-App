import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';


class GenreTabBar extends StatelessWidget
{
  final Function(String) onGenreSelected;
  final List<String> genres;

  const GenreTabBar({super.key, required this.genres,required this.onGenreSelected});
   @override
  Widget build(BuildContext context) {

    return  Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TabBar(
          dividerHeight: 0,
        tabAlignment: TabAlignment.center,
        labelColor: ColorsManager.PrimaryColor,
        unselectedLabelColor:ColorsManager.onPrimaryColor ,
        isScrollable: true,
          labelPadding: EdgeInsets.symmetric(horizontal: 8),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelStyle:TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ColorsManager.onPrimaryColor ,
        ),
        labelStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
         color:  ColorsManager.PrimaryColor,
        ),

        indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
          color: ColorsManager.onPrimaryColor ,
        ),
          tabs:genres.map((genre) {

            return Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ColorsManager.onPrimaryColor,
                  ),
                ),
                child: Text(genre.tr()),
              ),
            );
          }).toList(),
          onTap: (index) {

            onGenreSelected(genres[index]);
            })
      ),
    );}


  }