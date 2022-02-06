import 'package:get/instance_manager.dart';

import 'core_badge_cart.dart';

class CoreBadgeCartBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => CoreBadgeCart());
  }
}