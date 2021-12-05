import 'package:get/instance_manager.dart';

import '../properties/theme/app_theme_controller.dart';

class AppThemeBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<AppThemeController>(() => AppThemeController());
  }
}