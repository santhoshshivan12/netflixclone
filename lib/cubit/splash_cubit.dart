import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void updateAnimationProgress(double progress) {
    emit(SplashAnimating(progress));
    if (progress >= 1.0) {
      emit(SplashLoaded());
    }
  }
} 