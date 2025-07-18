import 'package:flutter/material.dart';
import 'package:netflixclone/utils/Custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'nav_helper/nav_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Netflix_Clone',
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: NavHelper.router,
    );
  }
}



