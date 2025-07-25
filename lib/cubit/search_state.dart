part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> results;
  final String query;
  final String? genreId;

  SearchLoaded({
    required this.results,
    required this.query,
    this.genreId,
  });
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
} 