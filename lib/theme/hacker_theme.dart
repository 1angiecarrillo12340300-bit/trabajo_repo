import 'package:flutter/material.dart';

ThemeData hackerTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.greenAccent,
    elevation: 0,
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.greenAccent,
      fontFamily: 'Courier',
      fontSize: 14,
    ),
    titleLarge: TextStyle(
      color: Colors.greenAccent,
      fontFamily: 'Courier',
      fontWeight: FontWeight.bold,
    ),
  ),

  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.greenAccent,
    brightness: Brightness.dark,
  ),
);