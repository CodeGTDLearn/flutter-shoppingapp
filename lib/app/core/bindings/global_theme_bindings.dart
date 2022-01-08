import 'package:get/instance_manager.dart';

import '../theme/global_theme_controller.dart';



class GlobalThemeBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => GlobalThemeController());
  }
}