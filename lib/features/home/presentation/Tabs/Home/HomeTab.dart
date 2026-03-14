import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import 'package:movies_app/core/routing/app_router.dart';
import 'package:movies_app/features/home/domain/entities/movie.dart';
import 'package:movies_app/features/home/presentation/cubit/movies_cubit.dart';
import 'package:movies_app/features/home/presentation/cubit/movies_state.dart';
import 'package:movies_app/features/home/presentation/widget/Moviesitem.dart';
import 'package:movies_app/features/home/presentation/widget/Small_MovieItem.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  final PageController _pageController = PageController(viewportFraction: 0.5);
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<MoviesCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading || state is MoviesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MoviesError) {
          return Center(
            child: Text(state.message,
                style: const TextStyle(color: Colors.white)),
          );
        }

        if (state is MoviesLoaded) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return const Center(
              child: Text('No movies found',
                  style: TextStyle(color: Colors.white)),
            );
          }

          final Movie featured = movies[_selectedIndex];

          return Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: featured.poster,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) =>
                      Container(color: Colors.grey[900]),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.black54],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringsManager.movies.tr(),
                            style: TextStyle(
                              color: ColorsManager.SecondaryColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                featured.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  color: ColorsManager.SecondaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() => _selectedIndex = index);
                        },
                        controller: _pageController,
                        itemCount: movies.length,
                        itemBuilder: (context, index) => Moviesitem(
                          index: index,
                          selectedIndex: _selectedIndex,
                          movie: movies[index],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              featured.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorsManager.SecondaryColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => context.push(
                                AppRouter.movieDetails, extra: featured),
                            child: Row(
                              children: [
                                TextButton(onPressed: () {
                                  context.push(
                                    AppRouter.browse,

                                  );
                                }, child: Text(
                                  StringsManager.seemore.tr(),
                                  style: TextStyle(
                                    color: ColorsManager.onPrimaryColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward,
                                    color: ColorsManager.onPrimaryColor,
                                    size: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        itemCount:
                            movies.length + (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == movies.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                ),
                              ),
                            );
                          }
                          return SmallMovieItem(movie: movies[index]);
                        },
                      ),
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
