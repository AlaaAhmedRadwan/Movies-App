import 'package:dio/dio.dart';
import '../models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final Dio dio;

  MoviesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await dio.get(
      'https://movies-api.accel.li/api/v2/list_movies.json',
    );

    final moviesJson = (response.data['data']['movies'] as List?) ?? [];

    return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
  }
}
