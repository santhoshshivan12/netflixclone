// nav_helper.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/model.dart';
import '../Screens/Login.dart';
import '../Screens/Splash.dart';
import '../Screens/home.dart';
import '../Screens/onboarding.dart';
import '../Screens/search.dart';
import '../Screens/newhot.dart';
import '../Screens/Profile.dart';

class NavHelper {
  static late final GoRouter router;
  static bool _hasSeenOnboarding = false;
  static bool _isLoggedIn = false;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      // Clear preferences for testing (remove in production)
      await prefs.clear();
      
      _hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      debugPrint('Initial State - HasSeenOnboarding: $_hasSeenOnboarding, IsLoggedIn: $_isLoggedIn');

      router = GoRouter(
        initialLocation: '/',
        debugLogDiagnostics: true, // Enable debug logging
        redirect: _handleRedirect,
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              debugPrint('Building Splash Screen');
              return const SplashScreen();
            },
          ),
          GoRoute(
            path: '/onboarding',
            builder: (context, state) {
              debugPrint('Building Onboarding Screen');
              return const OnboardingScreen();
            },
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) {
              debugPrint('Building Login Screen');
              return const LoginScreen();
            },
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/newhot',
            builder: (context, state) {
              final movie = state.extra as Movie?;
              if (movie == null) {
                return const HomeScreen();
              }
              return NewHotScreen(movie: movie);
            },
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
        errorBuilder: (context, state) => const HomeScreen(),
      );

      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing NavHelper: $e');
      router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      );
      _isInitialized = true;
    }
  }

  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    if (!_isInitialized) return '/';

    final isInitialRoute = state.matchedLocation == '/';
    final isOnboardingRoute = state.matchedLocation == '/onboarding';
    final isLoginRoute = state.matchedLocation == '/login';
    final isHomeRoute = state.matchedLocation == '/home';

    debugPrint('Handling redirect - Current location: ${state.matchedLocation}');
    debugPrint('State - HasSeenOnboarding: $_hasSeenOnboarding, IsLoggedIn: $_isLoggedIn');

    // Always show splash first
    if (isInitialRoute) {
      return null; // Let splash screen handle initial navigation
    }

    // After splash, handle navigation based on state
    if (!_hasSeenOnboarding && !isOnboardingRoute) {
      debugPrint('Redirecting to onboarding');
      return '/onboarding';
    }

    if (_hasSeenOnboarding && !_isLoggedIn && !isLoginRoute && !isInitialRoute) {
      debugPrint('Redirecting to login');
      return '/login';
    }

    if (_isLoggedIn && (isLoginRoute || isOnboardingRoute)) {
      debugPrint('Redirecting to home');
      return '/home';
    }

    debugPrint('No redirect needed');
    return null;
  }

  static Future<void> setOnboardingSeen() async {
    try {
      debugPrint('Setting onboarding as seen');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenOnboarding', true);
      _hasSeenOnboarding = true;
      debugPrint('Onboarding marked as seen');
    } catch (e) {
      debugPrint('Error setting onboarding seen: $e');
    }
  }

  static Future<void> setLoggedIn(bool value) async {
    try {
      debugPrint('Setting logged in status: $value');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', value);
      _isLoggedIn = value;
      debugPrint('Logged in status updated');
    } catch (e) {
      debugPrint('Error setting logged in status: $e');
    }
  }

  static bool get isInitialized => _isInitialized;
}

Widget pageTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(animation),
    child: child,
  );
}
