import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movies_app/core/network/api_constants.dart';

import '../models/movies_response.dart';

part 'movies_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MoviesApiService {
  factory MoviesApiService(
      Dio dio, {
        String? baseUrl,
      }) = _MoviesApiService;

  @GET('list_movies.json')
  Future<MovieResponse> getMovies(
      @Query('page') int page,
      @Query('limit') int limit,
      );
}