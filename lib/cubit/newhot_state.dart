part of 'newhot_cubit.dart';

@immutable
abstract class NewHotState {}

class NewHotInitial extends NewHotState {}

class NewHotLoaded extends NewHotState {
  final Movie movie;
  final bool isFavorite;

  NewHotLoaded({
    required this.movie,
    this.isFavorite = false,
  });

  NewHotLoaded copyWith({
    Movie? movie,
    bool? isFavorite,
  }) {
    return NewHotLoaded(
      movie: movie ?? this.movie,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
} 