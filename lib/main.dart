import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:netflixclone/utils/Custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:netflixclone/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'nav_helper/nav_helper.dart';
import 'cubit/search_cubit.dart';
import 'cubit/home_cubit.dart';
import 'cubit/login_cubit.dart';
import 'cubit/newhot_cubit.dart';
import 'cubit/onboarding_cubit.dart';
import 'cubit/splash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize NavHelper before running the app
  await NavHelper.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('ta'),
        Locale('te'),
        Locale('kn'),
        Locale('ml'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = LoginCubit();
            cubit.startAuthStateListener();
            return cubit;
          },
        ),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => NewHotCubit()),
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => SplashCubit()),
      ],
      child: MaterialApp.router(
        title: 'Netflix Clone',
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: NavHelper.router,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}



