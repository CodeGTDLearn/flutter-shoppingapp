import 'package:get/instance_manager.dart';

import '../../../modules/overview/core/components/overview_appbar/overview_appbar.dart';
import '../../../modules/overview/core/components/overview_appbar/overview_sliver_appbar.dart';
import '../../../modules/overview/core/overview_keys.dart';
import '../badge/badge_cart.dart';
import '../badge/badge_cart_bindings.dart';
import 'custom_appbar.dart';
import 'custom_sliver_appbar.dart';

class AppbarsBindings extends Bindings {
  void dependencies() {
    BadgeCartBindings().dependencies();
    Get.lazyPut(() => OverviewKeys());
    Get.lazyPut(() => CustomAppBar());
    Get.lazyPut(() => OverviewAppBar());
    Get.lazyPut(() => CustomSliverAppBar());
    Get.lazyPut(() => OverviewSliverAppBar(cart: Get.find<BadgeCart>()));
  }
}