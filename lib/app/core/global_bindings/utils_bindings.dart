import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/utils/animations_utils.dart';
import 'package:shopingapp/app/core/utils/ui_utils.dart';

class UtilsBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<UiUtils>(() => UiUtils());
    Get.lazyPut<AnimationsUtils>(() => AnimationsUtils());
  }
}