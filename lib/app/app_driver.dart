import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'config/app_properties.dart';
import 'modules/core/app_theme/app_theme.dart';
import 'modules/core/app_theme/app_theme_store.dart';
import 'modules/core/shared_preferences/shared_preferences_repo.dart';

class AppDriver extends StatefulWidget {
  @override
  _AppDriverState createState() => _AppDriverState();
}

class _AppDriverState extends State<AppDriver> {
  final _theme = Modular.get<AppTheme>(); // era VAR
  final _sharedPref = Modular.get<SharedPreferencesRepo>(); // era VAR
  final _appThemeStore = Modular.get<AppThemeStore>(); // era VAR

  @override
  Widget build(BuildContext context) {
    _sharedPref.get('isDark').then(
        (value) => {_appThemeStore.isDark = value == null ? false : value});

    return Observer(
        builder: (_) => MaterialApp(
            debugShowCheckedModeBanner: APP_DEBUG_CHECK,
            title: APP_TITLE,
            theme: _theme.theme(_appThemeStore.isDark),
            navigatorKey: Modular.navigatorKey,
            onGenerateRoute: Modular.generateRoute));
  }
}
