import 'package:get/instance_manager.dart';

import '../../../modules/overview/core/components/overview_appbar/overview_appbar.dart';
import '../../../modules/overview/core/overview_keys.dart';
import 'core_appbar.dart';

class CoreAppbarsBindings extends Bindings {
  void dependencies() {
    // CoreBadgeCartBindings().dependencies();
    Get.lazyPut(() => OverviewKeys());
    Get.lazyPut(() => CoreAppBar());
    Get.lazyPut(() => OverviewAppBar());
    // Get.lazyPut(() => CoreSliverAppBar());
    // Get.lazyPut(() => OverviewSliverAppBar(cart: Get.find<CoreBadgeCart>()));
  }
}