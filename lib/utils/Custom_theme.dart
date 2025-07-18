import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

get darkTheme => ThemeData(
    primarySwatch: Colors.grey,
    appBarTheme: AppBarTheme(
      color: Colors.black, systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.blueGrey),
      labelStyle: TextStyle(color: Colors.white),
    ),
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    hintColor: Colors.red,
    iconTheme: IconThemeData(color: Colors.white)
);