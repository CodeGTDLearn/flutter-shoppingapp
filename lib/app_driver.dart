import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'app/core/properties/properties.dart';
import 'app/core/properties/routes.dart';
import 'app/core/shared_preferences/shared_prefs_repo.dart';
import 'app/core/theme/global_theme.dart';
import 'app/core/theme/global_theme_controller.dart';

void main() => runApp(AppDriver());

class AppDriver extends StatelessWidget {
  final _appTheme = Get.put(GlobalTheme());
  final _darkTheme = Get.put(GlobalThemeController());
  final _sharedPrefsRepo = Get.put(SharedPrefsRepo());

  @override
  Widget build(BuildContext context) {
    _sharedPrefsRepo.get('isDarkOption').then((darkOption) => darkOption == null
        ? _darkTheme.isDark.value = false
        : _darkTheme.isDark.value = darkOption);

    return GetMaterialApp(
      navigatorKey: APP_CONTEXT_GLOBAL_KEY,
      debugShowCheckedModeBanner: APP_DEBUG_CHECK,
      title: APP_TITLE,
      theme: _appTheme.theme(_darkTheme.isDark.value),
      initialRoute: Routes.OVERVIEW_ALL,
      getPages: Routes.getAppRoutes,
    );
  }
}