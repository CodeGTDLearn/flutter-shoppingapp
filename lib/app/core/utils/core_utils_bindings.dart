import 'package:get/instance_manager.dart';

import '../components/core_adaptive_widgets.dart';
import 'core_animations_utils.dart';
import 'core_ui_utils.dart';

class CoreUtilsBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => CoreUiUtils());
    Get.lazyPut(() => CoreAnimationsUtils());
    Get.lazyPut(() => CoreAdaptiveWidgets());
  }
}