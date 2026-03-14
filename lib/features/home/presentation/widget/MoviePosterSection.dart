import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/di/get_it.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import 'package:movies_app/core/reusable/CustomButton.dart';
import 'package:movies_app/features/home/data/services/firebase_movies_service.dart';
import 'package:movies_app/features/home/domain/entities/movie_torrent.dart';
import 'package:movies_app/features/home/domain/entities/wishlist_movie.dart';
import 'package:movies_app/features/home/presentation/screen/TorrentPlayerScreen.dart';
import 'package:movies_app/features/home/presentation/widget/MovieStateItem.dart';

import '../../../../core/resources/ColorsManager.dart';

enum _WishlistStatus { loading, inWishlist, notInWishlist, success }

class Moviepostersection extends StatefulWidget {
  final String posterUrl;
  final String title;
  final int year;
  final int runtime;
  final double rating;
  final int likes;
  final int movieId;
  final List<MovieTorrent> torrents;

  const Moviepostersection({
    super.key,
    required this.posterUrl,
    required this.rating,
    required this.title,
    required this.runtime,
    required this.year,
    required this.likes,
    required this.movieId,
    this.torrents = const [],
  });

  @override
  State<Moviepostersection> createState() => _MoviepostersectionState();
}

class _MoviepostersectionState extends State<Moviepostersection> {
  final _service = sl<FirebaseMoviesService>();
  _WishlistStatus _status = _WishlistStatus.loading;

  bool get _isInWishlist => _status == _WishlistStatus.inWishlist;

  @override
  void initState() {
    super.initState();
    _checkWishlist();
  }

  Future<void> _checkWishlist() async {
    setState(() => _status = _WishlistStatus.loading);
    try {
      final result = await _service.isMovieInWishlist(widget.movieId);
      if (!mounted) return;
      setState(() => _status =
          result ? _WishlistStatus.inWishlist : _WishlistStatus.notInWishlist);
    } catch (e) {
      if (!mounted) return;
      setState(() => _status = _WishlistStatus.notInWishlist);
      _showError(e.toString());
    }
  }

  Future<void> _toggleWishlist() async {
    final wasInWishlist = _isInWishlist;
    setState(() => _status = _WishlistStatus.loading);
    try {
      if (wasInWishlist) {
        await _service.removeFromWishlist(widget.movieId);
      } else {
        await _service.addToWishlist(WishlistMovie(
          id: widget.movieId,
          title: widget.title,
          poster: widget.posterUrl,
          year: widget.year,
        ));
      }
      if (!mounted) return;
      setState(() => _status = _WishlistStatus.success);

      // Show success briefly then settle on final state
      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
      setState(() => _status = wasInWishlist
          ? _WishlistStatus.notInWishlist
          : _WishlistStatus.inWishlist);
    } catch (e) {
      if (!mounted) return;
      setState(() =>
          _status = wasInWishlist ? _WishlistStatus.inWishlist : _WishlistStatus.notInWishlist);
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorsManager.teritaryColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildBookmarkButton() {
    switch (_status) {
      case _WishlistStatus.loading:
        return SizedBox(
          width: 24.w,
          height: 24.h,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: ColorsManager.SecondaryColor,
          ),
        );
      case _WishlistStatus.success:
        return Icon(Icons.check_circle, color: Colors.green, size: 24.sp);
      case _WishlistStatus.inWishlist:
        return Icon(Icons.bookmark,
            color: ColorsManager.teritaryColor, size: 24.sp);
      case _WishlistStatus.notInWishlist:
        return Icon(Icons.bookmark_border,
            color: ColorsManager.SecondaryColor, size: 24.sp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: widget.posterUrl,
              fit: BoxFit.cover,
              height: 645.h,
              width: 430.w,
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
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back,
                            color: ColorsManager.SecondaryColor),
                      ),
                      IconButton(
                        onPressed: _status == _WishlistStatus.loading
                            ? null
                            : _toggleWishlist,
                        icon: _buildBookmarkButton(),
                      ),
                    ],
                  ),
                  Image.asset(Assetsmanager.watchbutton),
                  Text(
                    widget.title.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorsManager.SecondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    widget.year.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffADADAD),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomButton(
                    title: StringsManager.watch.tr(),
                    onClick: () {
                      if (widget.torrents.isEmpty) return;
                      _showQualityPicker(context);
                    },
                    backgroundColor: ColorsManager.teritaryColor,
                    textColor: ColorsManager.SecondaryColor,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Moviestateitem(
                          icon: Icons.favorite_rounded,
                          value: widget.likes.toString()),
                      Moviestateitem(
                          icon: Icons.access_time_filled_rounded,
                          value: widget.runtime.toString()),
                      Moviestateitem(
                          icon: Icons.star_outlined,
                          value: widget.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
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
            ...widget.torrents.map((t) => ListTile(
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
                          magnetLink: t.magnetLink(widget.title),
                          title: widget.title,
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
