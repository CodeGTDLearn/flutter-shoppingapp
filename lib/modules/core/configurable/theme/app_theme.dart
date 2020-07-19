import 'package:flutter/material.dart';

import 'theme_features.dart';

class AppTheme {

  ThemeData theme(bool isDark) {
    return ThemeData(
        primarySwatch: PRIMARY_SWATCH,
        accentColor: ACCENT_COLOR,
        cardColor: CARD_COLOR,
        brightness: isDark == true ? DARK : LIGHT,
        fontFamily: FONT_FAMILY);
  }
}
