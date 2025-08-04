import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/utils/Custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:netflixclone/firebase_options.dart';
import 'package:netflixclone/utils/SharedPrefHelper.dart';
import 'package:netflixclone/utils/notification_service.dart';

import 'nav_helper/nav_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  log('firebase ::Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefHelper().init();
  await NotificationService.instance.initialize();
  NotificationService.instance.subscribeToTopic("allUsers");
  NotificationService.instance.getDeviceToken();

  // Handle background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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



