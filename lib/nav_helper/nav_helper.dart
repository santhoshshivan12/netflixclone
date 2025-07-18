// nav_helper.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: NavRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: NavRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: NavRoutes.newHot,
        name: 'newHot',
        builder: (context, state) => const NewHotScreen(),
      ),
      GoRoute(
        path: NavRoutes.search,
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),

    ],
  );
}
