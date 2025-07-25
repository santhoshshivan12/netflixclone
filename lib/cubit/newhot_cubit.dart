import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Model/model.dart';
part 'newhot_state.dart';

class NewHotCubit extends Cubit<NewHotState> {
  NewHotCubit() : super(NewHotInitial());

  void loadMovie(Movie movie) {
    emit(NewHotLoaded(movie: movie));
  }

  void toggleFavorite() {
    if (state is NewHotLoaded) {
      final currentState = state as NewHotLoaded;
      emit(currentState.copyWith(
        isFavorite: !currentState.isFavorite
      ));
    }
  }
} 