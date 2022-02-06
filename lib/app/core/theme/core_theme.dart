import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreTheme {
  ThemeData materialThemeData(bool isDark) {
    return ThemeData(
        cardColor: Colors.white,
        // brightness: isDark ? DARK : LIGHT,
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
          secondary: Colors.deepOrange,
          brightness: isDark ? Brightness.dark : Brightness.light,
        ));
  }

  CupertinoThemeData cupertinoTheme() {
    return const CupertinoThemeData(
      primaryColor: Colors.red,
      // primaryContrastingColor: Color.fromARGB(255, 100, 100, 255),
      // barBackgroundColor: Color.fromARGB(255, 255, 100, 100),
      brightness: Brightness.light,
      textTheme: CupertinoTextThemeData(
          navLargeTitleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
            color: CupertinoColors.activeGreen,
          )),
    );
  }
}