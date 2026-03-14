import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/dio_factory.dart';

import 'package:movies_app/features/home/data/remote/movies_api_service.dart';
import 'package:movies_app/features/home/data/repositories/movies_repository_impl.dart';
import 'package:movies_app/features/home/data/services/firebase_movies_service.dart';

import 'package:movies_app/features/home/domain/repositories/movies_repository.dart';
import 'package:movies_app/features/home/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/features/home/domain/usecases/get_movies_usecase.dart';

import 'package:movies_app/features/home/presentation/cubit/movie_details_cubit.dart';
import 'package:movies_app/features/home/presentation/cubit/movies_cubit.dart';
import 'package:movies_app/features/home/presentation/cubit/search_cubit.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton<FirebaseMoviesService>(
    () => FirebaseMoviesService(),
  );

  sl.registerLazySingleton<Dio>(
        () => DioFactory.create(),
  );

  sl.registerLazySingleton<MoviesApiService>(
        () => MoviesApiService(
      sl<Dio>(),
      baseUrl: ApiConstants.baseUrl,
    ),
  );

  sl.registerLazySingleton<MoviesRepository>(
        () => MoviesRepositoryImpl(
      sl<MoviesApiService>(),
    ),
  );

  sl.registerLazySingleton<GetMoviesUseCase>(
        () => GetMoviesUseCase(
      sl<MoviesRepository>(),
    ),
  );

  sl.registerLazySingleton<GetMovieDetailsUseCase>(
        () => GetMovieDetailsUseCase(
      sl<MoviesRepository>(),
    ),
  );

  sl.registerFactory<MoviesCubit>(
        () => MoviesCubit(
      sl<GetMoviesUseCase>(),
    ),
  );

  sl.registerFactory<MovieDetailsCubit>(
        () => MovieDetailsCubit(
      sl<GetMovieDetailsUseCase>(),
      sl<GetMoviesUseCase>(),
    ),
  );

  sl.registerFactory<SearchCubit>(
        () => SearchCubit(
      sl<GetMoviesUseCase>(),
    ),
  );
}
