import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/properties/app_properties.dart';
import 'app/core/properties/app_routes.dart';
import 'app/core/properties/theme/app_theme.dart';
import 'app/core/properties/theme/app_theme_controller.dart';
import 'app/core/shared_preferences/i_shared_prefs_repo.dart';
import 'app/core/shared_preferences/shared_prefs_repo.dart';

void main() => runApp(AppDriver());

class AppDriver extends StatelessWidget {
  final _appTheme = Get.put(AppTheme());
  final _darkTheme = Get.put(AppThemeController());
  final _sharedPrefsRepo = Get.put<ISharedPrefsRepo>(SharedPrefsRepo());

  @override
  Widget build(BuildContext context) {
    _sharedPrefsRepo.get('isDarkOption').then((darkOption) => darkOption == null
        ? _darkTheme.isDark.value = false
        : _darkTheme.isDark.value = darkOption);

    return GetMaterialApp(
      debugShowCheckedModeBanner: APP_DEBUG_CHECK,
      title: APP_TITLE,
      theme: _appTheme.theme(_darkTheme.isDark.value),
      initialRoute: AppRoutes.OVERVIEW_ALL,
      getPages: AppRoutes.getAppRoutes,
    );
  }
}
