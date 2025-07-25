part of 'onboarding_cubit.dart';

@immutable
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingInProgress extends OnboardingState {
  final int currentPageIndex;
  final bool isAutoScrolling;

  OnboardingInProgress({
    required this.currentPageIndex,
    this.isAutoScrolling = true,
  });

  OnboardingInProgress copyWith({
    int? currentPageIndex,
    bool? isAutoScrolling,
  }) {
    return OnboardingInProgress(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isAutoScrolling: isAutoScrolling ?? this.isAutoScrolling,
    );
  }
}

class OnboardingCompleted extends OnboardingState {} 