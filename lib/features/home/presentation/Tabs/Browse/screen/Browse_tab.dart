import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/movies_cubit.dart';
import '../../../cubit/movies_state.dart';
import '../widget/GenreTabBar.dart';
import '../widget/MovieGrid.dart';

class BrowseTab extends StatefulWidget {

  const BrowseTab({super.key,});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  String selectedGenre = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {

          if (state is MoviesLoaded) {

            final movies = state.movies;

            final genres = movies
                .expand((movie) => movie.genres)
                .toSet()
                .toList();

            if (selectedGenre.isEmpty) {
              selectedGenre = genres.first;
            }

            final filteredMovies = movies.where((movie) {
              return movie.genres.contains(selectedGenre);
            }).toList();

            return DefaultTabController(
              length: genres.length,
              child:
                  
              SafeArea(
                child: Column(
                  children: [
                
                    GenreTabBar(
                      genres: genres,
                      onGenreSelected: (genre) {
                        setState(() {
                          selectedGenre = genre;
                        });
                      },
                    ),
                
                    Expanded(
                      child: MovieGrid(movies: filteredMovies),
                    )
                
                  ],
                ),
              ),
            );
          }

          if (state is MoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const SizedBox();
        }
    );
  }
}
