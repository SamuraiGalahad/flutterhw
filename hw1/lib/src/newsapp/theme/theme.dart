import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black54,
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white)));

final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black)));
