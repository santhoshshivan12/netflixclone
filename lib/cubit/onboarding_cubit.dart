import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Model/onboarding_entity.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  Timer? _autoScrollTimer;
  final _onBoardingData = OnBoardingEntity.onBoardingData;

  OnboardingCubit() : super(OnboardingInitial());

  void startOnboarding() {
    emit(OnboardingInProgress(currentPageIndex: 0));
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (state is OnboardingInProgress) {
        final currentState = state as OnboardingInProgress;
        if (currentState.currentPageIndex < _onBoardingData.length - 1) {
          updatePage(currentState.currentPageIndex + 1);
        } else {
          stopAutoScroll();
        }
      }
    });
  }

  void updatePage(int index) {
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      emit(currentState.copyWith(currentPageIndex: index));
    }
  }

  void stopAutoScroll() {
    _autoScrollTimer?.cancel();
    if (state is OnboardingInProgress) {
      final currentState = state as OnboardingInProgress;
      emit(currentState.copyWith(isAutoScrolling: false));
    }
  }

  void completeOnboarding() {
    _autoScrollTimer?.cancel();
    emit(OnboardingCompleted());
  }

  @override
  Future<void> close() {
    _autoScrollTimer?.cancel();
    return super.close();
  }
} 