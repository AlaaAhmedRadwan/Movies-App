import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';

class SimilarMovieItem extends StatelessWidget {
  final String imageUrl;
  final double rating;

 SimilarMovieItem({
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding:  EdgeInsets.symmetric(
                horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  rating.toString(),
                  style:  TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                 SizedBox(width: 4),
                 Icon(
                  Icons.star,
                  color: ColorsManager.onPrimaryColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}