import 'package:get/instance_manager.dart';

import '../custom_widgets/custom_appbar.dart';

class CustomAppbarBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomAppBar>(() => CustomAppBar());
  }
}