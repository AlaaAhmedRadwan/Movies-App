import 'package:movies_app/features/home/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getMovies({int page});
}