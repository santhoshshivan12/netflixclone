import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Model/model.dart';
import '../utils/MovieService.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MovieService _movieService = MovieService();
  
  SearchCubit() : super(SearchInitial());

  Future<void> search(String query, {String? genreId}) async {
    if (query.isEmpty && genreId == null) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await _movieService.searchMovies(query, genreId: genreId);
      emit(SearchLoaded(
        results: results,
        query: query,
        genreId: genreId,
      ));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
} 