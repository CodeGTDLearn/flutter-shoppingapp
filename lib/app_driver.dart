import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'app/core/properties/properties.dart';
import 'app/core/routes/core_router.dart';
import 'app/core/routes/core_routes.dart';
import 'app/core/shared_preferences/shared_prefs_repo.dart';
import 'app/core/theme/core_theme.dart';
import 'app/core/theme/core_theme_controller.dart';

// Solving MULTIDEX problem: https://www.youtube.com/watch?v=afW7dAndEyw
void main() => runApp(AppDriver());

class AppDriver extends StatelessWidget {
  final _appTheme = Get.put(CoreTheme());
  final _darkTheme = Get.put(CoreThemeController());
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
      theme: _appTheme.materialThemeData(_darkTheme.isDark.value),
      initialRoute: CoreRoutes.OVERVIEW_ALL,
      getPages: CoreRouter.getAppRoutes,
    );
  }
}