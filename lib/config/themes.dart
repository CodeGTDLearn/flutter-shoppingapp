import 'package:flutter/material.dart';

class AppTheme {
  //USING SINGLETON PATTERN: NO MORE THAN ONE INSTANCE IS NECESSARY
  static AppTheme _instance;

  AppTheme._internalConstructor();

  factory AppTheme() {
    _instance ??= AppTheme._internalConstructor();
    return _instance;
  }

  static final ThemeData _themeConfiguration = ThemeData(
      primarySwatch: Colors.blue,
      accentColor: Colors.deepOrange,
      canvasColor: Color.fromRGBO(255, 254, 229, 1),
      fontFamily: 'Lato');

  ThemeData get theme => _themeConfiguration;
}
