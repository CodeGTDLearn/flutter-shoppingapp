import 'package:get/instance_manager.dart';

import 'global_theme_controller.dart';

class GlobalThemeBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => GlobalThemeController());
  }
}