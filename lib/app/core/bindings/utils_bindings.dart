import 'package:get/instance_manager.dart';

import '../utils/adaptive_widget_utils.dart';
import '../utils/animations_utils.dart';
import '../utils/ui_utils.dart';

class UtilsBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => UiUtils());
    Get.lazyPut(() => AnimationsUtils());
    Get.lazyPut(() => AdaptiveWidgetUtils());
  }
}