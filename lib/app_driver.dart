import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import 'app/core/local_storage/local_storage_controller.dart';
import 'app/core/properties/properties.dart';
import 'app/core/routes/core_router.dart';
import 'app/core/routes/core_routes.dart';
import 'app/core/theme/core_theme.dart';

void main() async {
  await GetStorage.init();
  runApp(AppDriver());
}

class AppDriver extends StatelessWidget {
  final _theme = Get.put(CoreTheme());
  final _localStorage = Get.put(LocalStorageController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: APP_CONTEXT_GLOBAL_KEY,
      debugShowCheckedModeBanner: APP_DEBUG_CHECK,
      title: APP_TITLE,
      theme: _theme.materialLight,
      darkTheme: _theme.materialDark,
      themeMode: _localStorage.getTheme(),
      initialRoute: CoreRoutes.OVERVIEW_ALL,
      getPages: CoreRouter.getAppRoutes,
    );
  }
}