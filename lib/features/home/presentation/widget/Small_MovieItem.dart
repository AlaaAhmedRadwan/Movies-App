import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/features/home/domain/entities/movie.dart';

class SmallMovieItem extends StatelessWidget {
  final Movie movie;

  const SmallMovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: movie.poster,
              width: 130,
              height: 180,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: 130,
                height: 180,
                color: Colors.grey[900],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (_, __, ___) => Container(
                width: 130,
                height: 180,
                color: Colors.grey[800],
                child: const Icon(Icons.movie, color: Colors.white54),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    const SizedBox(width: 3),
                    const Icon(Icons.star, color: Colors.amber, size: 13),
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