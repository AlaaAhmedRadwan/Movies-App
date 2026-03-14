import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/repositories/movies_repository.dart';
import '../remote/movies_api_service.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesApiService api;

  MoviesRepositoryImpl(this.api);

  @override
  Future<List<Movie>> getMovies({int page = 1, String? query}) async {
    final response = await api.getMovies(page, 20, queryTerm: query);
    return response.data?.movies ?? [];
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final response = await api.getMovieDetails(movieId, true, true);
    final movie = response.movie;
    if (movie == null) throw Exception('Movie details not found');
    return movie.toEntity();
  }
}
