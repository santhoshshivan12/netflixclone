import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Model/model.dart';
import '../utils/MovieService.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieService _movieService = MovieService();
  
  HomeCubit() : super(HomeInitial());

  Future<void> loadInitialMovies() async {
    emit(HomeLoading());
    try {
      final movies = await _movieService.fetchTopRatedMovies(page: 1);
      emit(HomeLoaded(movies: movies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> loadMoreMovies() async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      if (currentState.isLoadingMore) return;

      try {
        emit(currentState.copyWith(isLoadingMore: true));
        final newMovies = await _movieService.fetchTopRatedMovies(
          page: currentState.currentPage + 1
        );
        
        emit(currentState.copyWith(
          movies: [...currentState.movies, ...newMovies],
          currentPage: currentState.currentPage + 1,
          isLoadingMore: false,
        ));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }

  void updateCurrentIndex(int index) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(currentIndex: index));
    }
  }
} 