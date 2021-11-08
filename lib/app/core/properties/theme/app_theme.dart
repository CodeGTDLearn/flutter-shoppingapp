import 'package:flutter/material.dart';

import 'app_theme_features.dart';

class AppTheme {
  ThemeData theme(bool isDark) {
    return ThemeData(
        cardColor: CARD_COLOR,
        // brightness: isDark ? DARK : LIGHT,
        fontFamily: FONT_FAMILY,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: PRIMARY_SWATCH).copyWith(
          secondary: ACCENT_COLOR,
          brightness: isDark ? DARK : LIGHT,
        ));
  }
}