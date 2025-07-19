// nav_helper.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Model/model.dart';
import '../Screens/Login.dart';
import '../Screens/Splash.dart';
import '../Screens/home.dart';
import '../Screens/newhot.dart';
import '../Screens/onboarding.dart';
import '../Screens/search.dart';
import 'nav_route.dart';


class NavHelper {
  static final GoRouter router = GoRouter(
    initialLocation: NavRoutes.splash,
    routes: [
      GoRoute(
        path: NavRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: NavRoutes.onBoarding,
        name: 'onBoarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: OnBoardingScreen(),
          transitionsBuilder: pageTransition, // Your function
        ),
      ),
      GoRoute(
        path: NavRoutes.login,
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: LoginScreen(),
          transitionsBuilder: pageTransition, // Your function
        ),
      ),
      GoRoute(
        path: NavRoutes.home,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: HomeScreen(),
          transitionsBuilder: pageTransition,
          transitionDuration: const Duration(milliseconds: 500),// Your function
        ),
      ),
      GoRoute(
        path: NavRoutes.newHot,
        name: 'newHot',
        pageBuilder: (context, state) {
          final movie = state.extra as Movie;
          return CustomTransitionPage(
          child: NewHotScreen(movie: movie),
          transitionsBuilder: pageTransition,
            transitionDuration: const Duration(milliseconds: 500),
          );},
      ),
      GoRoute(
        path: NavRoutes.search,
        name: 'search',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: SearchScreen(),
          transitionsBuilder: pageTransition, // Your function
        ),
      ),

    ],
  );
}
// Widget pageTransition(BuildContext context, Animation<double> animation,
//     Animation<double> secondaryAnimation, Widget child) {
//   final tween = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeInToLinear));
//   return ScaleTransition(
//     scale: tween,
//     child: child,
//   );
// }
Widget pageTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
}
