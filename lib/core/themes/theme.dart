import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class DefaultThemeData {
  final BuildContext context;

  DefaultThemeData({required this.context});

  ThemeData get defaultTheme {
    final theme = context.themeData.brightness;
    final bool isDark = theme == Brightness.dark;
    return ThemeData(
      fontFamily: "Inter",
      primaryColor: isDark
          ? DictionaryColors.whiteBackground
          : DictionaryColors.blackBackground,
      brightness: isDark ? Brightness.light : Brightness.dark,
      // textTheme: TextTheme(),
      // colorScheme: ColorScheme.fromSeed(
      //   seedColor: Colors.deepPurple,
      // ),
      useMaterial3: true,
    );
  }

  static TextTheme get genericTextTheme {
    return const TextTheme(
      bodySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: DictionaryColors.blackBackground,
      ),
      bodyLarge: TextStyle(fontSize: 18),
      displaySmall: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: DictionaryColors.blackBackground,
      ),
      displayMedium: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: DictionaryColors.blackBackground,
      ),
      displayLarge: TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.bold,
        color: DictionaryColors.blackBackground,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        color: DictionaryColors.blackBackground,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        color: DictionaryColors.blackBackground,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: DictionaryColors.blackBackground,
      ),
    );
  }
}
