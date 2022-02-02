import 'package:get/instance_manager.dart';

import 'badge_cart.dart';

class BadgeCartBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => BadgeCart());
  }
}