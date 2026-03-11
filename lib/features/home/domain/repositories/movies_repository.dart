import 'package:movies_app/features/home/domain/entities/movie.dart';
import 'package:movies_app/features/home/domain/entities/movie_details.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getMovies({int page, String? query,});
  Future<MovieDetails> getMovieDetails(int movieId);
}
