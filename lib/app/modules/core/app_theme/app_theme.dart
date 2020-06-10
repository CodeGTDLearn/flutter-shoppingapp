import 'package:flutter/material.dart';
import 'package:shopingapp/app/config/app_theme.dart';

class AppTheme {
  ThemeData theme(bool isDark) {
    return ThemeData(
        primarySwatch: PRIMARY_SWATCH,
        accentColor: ACCENT_COLOR,
        cardColor: CARD_COLOR,
        brightness: isDark == true ? Brightness.dark : Brightness.light,
        fontFamily: FONT_FAMILY);
  }
}
