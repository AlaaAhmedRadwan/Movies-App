import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetMoviesUseCase useCase;

  MoviesCubit(this.useCase) : super(MoviesInitial());

  void getMovies() async {
    emit(MoviesLoading());
    try {
      final movies = await useCase(page: 1);
      emit(MoviesLoaded(
        movies: movies,
        currentPage: 1,
        hasMore: movies.length == 20,
      ));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  void loadMore() async {
    final current = state;
    if (current is! MoviesLoaded) return;
    if (!current.hasMore || current.isLoadingMore) return;

    emit(current.copyWith(isLoadingMore: true));
    try {
      final nextPage = current.currentPage + 1;
      final newMovies = await useCase(page: nextPage);
      emit(current.copyWith(
        movies: [...current.movies, ...newMovies],
        currentPage: nextPage,
        hasMore: newMovies.length == 20,
        isLoadingMore: false,
      ));
    } catch (_) {
      emit(current.copyWith(isLoadingMore: false));
    }
  }
}