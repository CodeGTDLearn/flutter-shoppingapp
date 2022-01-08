import 'package:flutter/material.dart';


class GlobalTheme {
  ThemeData theme(bool isDark) {
    return ThemeData(
        cardColor: Colors.white,
        // brightness: isDark ? DARK : LIGHT,
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
          secondary: Colors.deepOrange,
          brightness: isDark ? Brightness.dark : Brightness.light,
        ));
  }
}