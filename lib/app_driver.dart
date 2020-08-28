import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/properties/app_properties.dart';
import 'app/core/properties/app_routes.dart';
import 'app/core/properties/theme/app_theme.dart';
import 'app/core/properties/theme/dark_theme_controller.dart';
import 'app/core/shared_preferences/i_shared_prefs_repo.dart';
import 'app/core/shared_preferences/shared_prefs_repo.dart';

class AppDriver extends StatelessWidget {
  final _appTheme = Get.put(AppTheme());
  final _darkTheme = Get.put(DarkThemeController());
  final _repo = Get.put<ISharedPrefsRepo>(SharedPrefsRepo());

  @override
  Widget build(BuildContext context) {
    _repo.get('isDarkOption').then((shared) => shared == null
        ? _darkTheme.isDark.value = false
        : _darkTheme.isDark.value = shared);

    return GetMaterialApp(
      debugShowCheckedModeBanner: APP_DEBUG_CHECK,
      title: APP_TITLE,

      theme: _appTheme.theme(_darkTheme.isDark.value),

      //Get PARAMETROS:
//      initialBinding: CoreBinding(),
//      smartManagement: SmartManagement.keepFactory,
//      home: OverviewPage(Popup.All),
      initialRoute: AppRoutes.OVERVIEW_ALL,
      getPages: AppRoutes.getAppRoutes,
    );
  }
}
