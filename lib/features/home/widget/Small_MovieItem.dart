import 'package:flutter/material.dart';

import '../../../model/BoosterModel.dart';

class SmallMovieItem extends StatelessWidget {
  final Boostermodel movie;

  const SmallMovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.asset(
              movie.imagePath,
              width: 130,
              height: 180,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      movie.rating.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11),
                    ),
                    SizedBox(width: 3),
                     Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 13,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}