import 'package:get/instance_manager.dart';

import '../../../modules/overview/components/overview_appbar/overview_appbar.dart';
import '../../../modules/overview/components/overview_appbar/overview_sliver_appbar.dart';
import '../../global_widgets/appbar/custom_appbar.dart';
import '../../global_widgets/appbar/custom_sliver_appbar.dart';
import '../../global_widgets/badge_cart.dart';
import '../../keys/modules/overview_keys.dart';
import 'badge_cart_bindings.dart';

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