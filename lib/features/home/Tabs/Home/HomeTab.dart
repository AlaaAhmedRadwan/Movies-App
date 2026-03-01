import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/features/home/widget/Moviesitem.dart';
import 'package:movies_app/features/home/widget/Small_MovieItem.dart';

import '../../../../core/resources/AppConstants.dart';
import '../../../../core/resources/AssetsManager.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  @override
  PageController controller=PageController(
    viewportFraction: 0.5,
  );
  int selectedIndex=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Appconstants.moviesList[selectedIndex].imagePath,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(

            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20
              ),
              child: Column(
                children: [
                  Image.asset(Assetsmanager.Available,
                    width:267.w,
                    fit: BoxFit.fitWidth,),
                  Expanded(
                    child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            selectedIndex=index;
                          });
                        },
                        controller: controller,
                        itemCount:Appconstants.moviesList.length,
                        itemBuilder: (context, index) =>Moviesitem(index: index,
                          selectedIndex: selectedIndex,
                          movie: Appconstants.moviesList[index],)
                    ),
                  ),

                  SizedBox(height: 10.h,),
                  Image.asset(Assetsmanager.watch,
                    width:354.w,
                    fit: BoxFit.fitWidth,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_back,color: ColorsManager.onPrimaryColor,),
                              TextButton(onPressed: () {

                              }, child: Text( "See More",
                                style: TextStyle(
                                  color: ColorsManager.onPrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),),),
                            ],
                          ),
                          Text("Action",
                            style: TextStyle(
                              color: ColorsManager.SecondaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,),),] ),),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: Appconstants.moviesList.length,
                        itemBuilder: (context, index)
                        => SmallMovieItem(movie: Appconstants.moviesList[index])),)
                ],
              ),
            ),

          )
        ],
      ),);}}