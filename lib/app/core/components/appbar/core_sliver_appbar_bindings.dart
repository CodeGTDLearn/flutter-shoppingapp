import 'package:get/instance_manager.dart';

import '../../../modules/overview/core/components/overview_appbar/overview_sliver_appbar.dart';
import '../badge/core_badge_cart.dart';
import 'core_sliver_appbar.dart';

class CoreSliverAppBarBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => CoreSliverAppBar());
    Get.lazyPut(() => OverviewSliverAppBar(cart: Get.find<CoreBadgeCart>()));
  }
}