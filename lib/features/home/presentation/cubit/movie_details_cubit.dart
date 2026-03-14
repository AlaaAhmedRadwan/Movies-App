import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUseCase useCase;
  final GetMoviesUseCase moviesUseCase;

  MovieDetailsCubit(this.useCase, this.moviesUseCase) : super(MovieDetailsInitial());

  void getDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final details = await useCase(movieId);
      final genre = details.genres.isNotEmpty ? details.genres.first : null;
      final similar = await moviesUseCase(page: 1, query: genre)
          .then((list) => list.where((m) => m.id != movieId).take(6).toList());
      emit(MovieDetailsLoaded(details, similarMovies: similar));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}
