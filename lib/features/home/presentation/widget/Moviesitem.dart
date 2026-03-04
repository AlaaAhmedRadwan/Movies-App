import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/core/routing/app_router.dart';
import 'package:movies_app/features/home/domain/entities/movie.dart';
import 'package:movies_app/features/home/presentation/screen/MovieDetails.dart';

class Moviesitem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final Movie movie;

  const Moviesitem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isSelected ? 0 : 20,
      ),
      height: isSelected ? 320 : 290,
      child: InkWell(
        onTap: () {
          context.push(
            AppRouter.movieDetails,
              extra: movie);

        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: movie.poster,
                fit: BoxFit.cover,
                height: isSelected ? 320 : 290,
                width: double.infinity,
                placeholder: (_, __) => Container(
                  color: Colors.grey[900],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: Colors.grey[800],
                  child: const Icon(Icons.movie, color: Colors.white54, size: 60),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      color: ColorsManager.onPrimaryColor,
                      size: 14,
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
