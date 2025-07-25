import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/splash_cubit.dart';
import '../nav_helper/nav_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward().then((_) => _navigateNext());
  }

  Future<void> _navigateNext() async {
    if (!mounted) return;
    
    // Add a small delay to ensure animations complete
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    debugPrint('Splash Navigation - HasSeenOnboarding: $hasSeenOnboarding, IsLoggedIn: $isLoggedIn');

    if (!hasSeenOnboarding) {
      if (mounted) {
        debugPrint('Navigating to onboarding from splash');
        context.go('/onboarding');
      }
    } else if (!isLoggedIn) {
      if (mounted) {
        debugPrint('Navigating to login from splash');
        context.go('/login');
      }
    } else {
      if (mounted) {
        debugPrint('Navigating to home from splash');
        context.go('/home');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'images/netflix.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
