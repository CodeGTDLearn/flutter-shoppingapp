import 'package:get/instance_manager.dart';

import '../utils/animations_utils.dart';
import '../utils/ui_utils.dart';
import '../utils/widget_platform_utils.dart';

class UtilsBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<UiUtils>(() => UiUtils());
    Get.lazyPut<AnimationsUtils>(() => AnimationsUtils());
    Get.lazyPut<WidgetPlatformUtils>(() => WidgetPlatformUtils());
  }
}