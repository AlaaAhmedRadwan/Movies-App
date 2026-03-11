import 'package:movies_app/features/home/domain/entities/movie.dart';
import 'package:movies_app/features/home/domain/repositories/movies_repository.dart';

class GetMoviesUseCase {
  final MoviesRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<Movie>> call({int page = 1, String? query,}) {
    return repository.getMovies(page: page, query: query,);
  }
}