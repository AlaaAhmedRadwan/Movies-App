import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
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
  final PageController controller = PageController(viewportFraction: 0.5);
  int selectedIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading || state is MoviesInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is MoviesError) {
          return Scaffold(
            body: Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.white)),
            ),
          );
        }

        if (state is MoviesLoaded) {
          final movies = state.movies;

          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    movies[selectedIndex].poster,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: Colors.grey[900]),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          Assetsmanager.Available,
                          width: 267.w,
                          fit: BoxFit.fitWidth,
                        ),
                        Expanded(
                          child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() => selectedIndex = index);
                            },
                            controller: controller,
                            itemCount: movies.length,
                            itemBuilder: (context, index) => Moviesitem(
                              index: index,
                              selectedIndex: selectedIndex,
                              movie: movies[index],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Image.asset(
                          Assetsmanager.watch,
                          width: 354.w,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.arrow_back,
                                      color: ColorsManager.onPrimaryColor),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'See More',
                                      style: TextStyle(
                                        color: ColorsManager.onPrimaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                movies[selectedIndex].genres.isNotEmpty
                                    ? movies[selectedIndex].genres.first
                                    : '',
                                style: const TextStyle(
                                  color: ColorsManager.SecondaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: movies.length,
                            itemBuilder: (context, index) =>
                                SmallMovieItem(movie: movies[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}