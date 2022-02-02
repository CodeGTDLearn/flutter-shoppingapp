import 'package:get/instance_manager.dart';

import '../components/adaptive_widgets.dart';
import 'animations_utils.dart';
import 'ui_utils.dart';

class UtilsBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => UiUtils());
    Get.lazyPut(() => AnimationsUtils());
    Get.lazyPut(() => AdaptiveWidgets());
  }
}