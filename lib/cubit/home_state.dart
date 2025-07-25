part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Movie> movies;
  final bool isLoadingMore;
  final int currentPage;
  final int currentIndex;

  HomeLoaded({
    required this.movies,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.currentIndex = 0,
  });

  HomeLoaded copyWith({
    List<Movie>? movies,
    bool? isLoadingMore,
    int? currentPage,
    int? currentIndex,
  }) {
    return HomeLoaded(
      movies: movies ?? this.movies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
} 