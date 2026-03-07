import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUseCase useCase;

  MovieDetailsCubit(this.useCase) : super(MovieDetailsInitial());

  void getDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final details = await useCase(movieId);
      emit(MovieDetailsLoaded(details));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}
