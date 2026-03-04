import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';
import '../remote/movies_api_service.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesApiService api;

  MoviesRepositoryImpl(this.api);

  @override
  Future<List<Movie>> getMovies({int page = 1}) async {
    final response = await api.getMovies(page, 20);
    return response.data?.movies ?? [];
  }
}