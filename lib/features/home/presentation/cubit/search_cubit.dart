import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetMoviesUseCase useCase;

  SearchCubit(this.useCase) : super(SearchInitial());

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final movies = await useCase(page: 1, query: query.trim());
      if (movies.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(movies));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clear() => emit(SearchInitial());
}
