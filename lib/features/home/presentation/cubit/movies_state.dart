import '../../domain/entities/movie.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;

  MoviesLoaded({
    required this.movies,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  MoviesLoaded copyWith({
    List<Movie>? movies,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return MoviesLoaded(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class MoviesError extends MoviesState {
  final String message;
  MoviesError(this.message);
}