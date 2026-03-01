import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetMoviesUseCase useCase;

  MoviesCubit(this.useCase) : super(MoviesInitial());

  void getMovies() async {
    emit(MoviesLoading());
    try {
      final movies = await useCase();
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}