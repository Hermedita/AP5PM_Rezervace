import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey.shade900
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,
    primary: Colors.white,
    secondary: Colors.grey.shade100
  )
);