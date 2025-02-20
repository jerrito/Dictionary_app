import 'package:flutter/material.dart';

class DefaultThemeData {
  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: "Inter",
      primaryColor: Colors.white,
      brightness: Brightness.dark,
      primaryColorDark: Colors.white,
      primaryColorLight: Colors.white,
      textTheme: TextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: "Inter",
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }
}
