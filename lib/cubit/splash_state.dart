part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashAnimating extends SplashState {
  final double animationProgress;
  
  SplashAnimating(this.animationProgress);
}

class SplashLoaded extends SplashState {} 