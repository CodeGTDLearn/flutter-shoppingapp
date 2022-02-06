import 'package:get/instance_manager.dart';

import 'core_theme_controller.dart';

class CoreThemeBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => CoreThemeController());
  }
}