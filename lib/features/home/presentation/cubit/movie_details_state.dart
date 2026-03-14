import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetails details;
  final List<Movie> similarMovies;
  MovieDetailsLoaded(this.details, {this.similarMovies = const []});
}

class MovieDetailsError extends MovieDetailsState {
  final String message;
  MovieDetailsError(this.message);
}
