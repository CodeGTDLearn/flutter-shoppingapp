import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'config/app_properties.dart';
import 'config/app_routes.dart';
import 'modules/core/app_theme/app_theme.dart';
import 'modules/core/app_theme/dark_theme_store.dart';
import 'modules/core/shared_preferences/shared_preferences_repo.dart';
import 'modules/overview/components/popup_appbar_enum.dart';
import 'modules/overview/pages/overview_page.dart';

class AppDriver extends StatelessWidget {

  final _theme = AppTheme();
  final _appThemeStore = DarkThemeStore();
  final _sharedPref = SharedPreferencesRepo();

  @override
  Widget build(BuildContext context) {
    _sharedPref.get('isDark').then(
        (value) => {_appThemeStore.isDark = value == null ? false : value});

    return GetMaterialApp(
      debugShowCheckedModeBanner: APP_DEBUG_CHECK,
      title: APP_TITLE,
      theme: _theme.theme(_appThemeStore.isDark),

      //Get PARAMETROS:
      home: OverviewPage(Popup.All),
      initialRoute: OVERVIEW_ALL_ROUTE, // USUALLY '/'-ROTA DE 'RETORNO RAIZ'
      getPages: getAppRoutes,
    );
  }
}
