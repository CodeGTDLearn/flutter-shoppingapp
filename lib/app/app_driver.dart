import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:shopingapp/app/config/core_binding.dart';

import 'config/app_properties.dart';
import 'config/app_routes.dart';
import 'modules/core/app_theme/app_theme.dart';
import 'modules/core/app_theme/dark_theme_controller.dart';
import 'modules/core/shared_preferences/shared_prefs_repo.dart';
import 'modules/overview/components/popup_appbar_enum.dart';
import 'modules/overview/pages/overview_page.dart';

class AppDriver extends StatelessWidget {
  final _appTheme = Get.put(AppTheme());
  final _darkThemeController = Get.put(DarkThemeController());
  final SharedPrefsRepo _repo = Get.put(SharedPrefsRepo());

  @override
  Widget build(BuildContext context) {
    _repo.get('isDarkOption').then(
          (value) => {
            value == null
                ? _darkThemeController.isDark.value = false
                : _darkThemeController.isDark.value = value,
          },
        );

    return GetMaterialApp(
      debugShowCheckedModeBanner: APP_DEBUG_CHECK,
      title: APP_TITLE,

      //todo: trabalhando no darktheme, parei aqui
      theme: _appTheme.theme(_darkThemeController.isDark.value),

      //Get PARAMETROS:
      initialBinding: CoreBinding(),
      smartManagement: SmartManagement.keepFactory,
      home: OverviewPage(Popup.All),
      initialRoute: OVERVIEW_ALL_ROUTE,
      getPages: getAppRoutes,
    );
  }
}
