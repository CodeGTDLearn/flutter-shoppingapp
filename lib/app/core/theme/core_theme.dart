import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreTheme {

  final materialLight = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    fontFamily: 'Lato',
    // colorScheme: darkScheme,
    primaryColor: Colors.pink,
    brightness: Brightness.light,
  );

  final materialDark = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.deepPurple,
    fontFamily: 'Lato',
    // colorScheme: darkScheme,
    primaryColor: Colors.blueGrey,
    brightness: Brightness.dark,
  );

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