import 'package:flutter/material.dart';
import 'package:movies_app/model/BoosterModel.dart';

import '../../../core/resources/ColorsManager.dart';

class Moviesitem extends StatefulWidget {
  int index;
  int selectedIndex;
  Boostermodel movie;
 Moviesitem({required this.index, required this.selectedIndex, required this.movie});


  @override
  State<Moviesitem> createState() => _MoviesitemState();
}

class _MoviesitemState extends State<Moviesitem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    bool isSelected = widget.index == widget.selectedIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isSelected ? 0 :20,
      ),
      height: isSelected ? 320 : 290,
        child: Stack(
          children: [
            ClipRRect(
        borderRadius: BorderRadius.circular(20),
              child: Image.asset(
               widget. movie.imagePath,
                fit: BoxFit.cover,
                height: isSelected ? 320 : 290,
                width: double.infinity,
              ),
            ),
            Positioned(
            top: 10,
            left: 10,
            child: Container(
            padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 3,
            ),
            decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
            children: [
            Text(
            widget.movie.rating.toString(),
            style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            ),
            ),
            const SizedBox(width: 4),
            const Icon(
            Icons.star,
            color: ColorsManager.onPrimaryColor,
            size: 14,
            ),],),),),],),);
  }
}
