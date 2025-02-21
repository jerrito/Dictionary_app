import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class DefaultThemeData {
  final BuildContext context;

  DefaultThemeData({required this.context});

  ThemeData defaultTheme(Brightness brightness) {
    // final theme = context.themeData.brightness;
    bool isDark = brightness == Brightness.dark;
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
        textTheme: genericTextTheme(brightness));
  }

  static TextTheme genericTextTheme(Brightness brightness) {
    bool isDark = brightness != Brightness.dark;

    return TextTheme(
      bodySmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: isDark
              ? DictionaryColors.whiteBackground
              : DictionaryColors.blackBackground),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isDark
            ? DictionaryColors.whiteBackground
            : DictionaryColors.blackBackground,
      ),
      bodyLarge: TextStyle(
          fontSize: 18,
          color: isDark
              ? DictionaryColors.whiteBackground
              : DictionaryColors.blackBackground),
      labelSmall: TextStyle(
          color: isDark
              ? DictionaryColors.whiteBackground
              : DictionaryColors.blackBackground),
      labelMedium: TextStyle(
          color: isDark
              ? DictionaryColors.whiteBackground
              : DictionaryColors.blackBackground),
      labelLarge: TextStyle(
          color: isDark
              ? DictionaryColors.whiteBackground
              : DictionaryColors.blackBackground),
      displaySmall: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: isDark
            ? DictionaryColors.whiteBackground
            : DictionaryColors.blackBackground,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: isDark
            ? DictionaryColors.whiteBackground
            : DictionaryColors.blackBackground,
      ),
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: isDark
            ? DictionaryColors.whiteBackground
            : DictionaryColors.blackBackground,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        color: isDark
            ? DictionaryColors.whiteBackground
            : DictionaryColors.blackBackground,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        color: isDark
            ? DictionaryColors.whiteBackground
            : DictionaryColors.blackBackground,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: isDark
            ? DictionaryColors.whiteBackground
            : DictionaryColors.blackBackground,
      ),
    );
  }

  //BOTTOM NAVIGATION BAR THEME
  static bottomNavigationBarThemeLight(Brightness brightness) {
    bool isDark = brightness != Brightness.dark;

    return BottomNavigationBarThemeData(
      backgroundColor: DictionaryColors.whiteBackground,
      unselectedItemColor: DictionaryColors.blackBackground,
      selectedItemColor: isDark
          ? DictionaryColors.whiteBackground
          : DictionaryColors.blackBackground,
      showSelectedLabels: true,
      showUnselectedLabels: true,

      unselectedIconTheme: IconThemeData(
          color: isDark
              ? DictionaryColors.whiteBackground
              : DictionaryColors.blackBackground),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: DictionaryColors.whiteBackground),
      // selectedItemColor: Colors.shaqBlack500,
      // unselectedItemColor: Colors.shaqGrey700,
      // backgroundColor: Colors.shaqBackgroundLight,
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        // color: .shaqBlack500,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        // color: Colors.shaqGrey700,
      ),
    );
  }
}
