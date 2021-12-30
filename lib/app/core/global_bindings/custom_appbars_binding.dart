import 'package:get/instance_manager.dart';

import '../../modules/overview/core/overview_appbar/badge_cart.dart';
import '../../modules/overview/core/overview_appbar/overview_appbar.dart';
import '../../modules/overview/core/overview_appbar/overview_sliver_appbar.dart';
import '../custom_widgets/custom_appbar.dart';
import '../custom_widgets/custom_sliver_appbar.dart';

class CustomAppbarsBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<BadgeCart>(() => BadgeCart());
    Get.lazyPut<CustomAppBar>(() => CustomAppBar());
    Get.lazyPut<OverviewAppBar>(() => OverviewAppBar());
    Get.lazyPut<CustomSliverAppBar>(() => CustomSliverAppBar());
    Get.lazyPut<OverviewSliverAppBar>(() => OverviewSliverAppBar(cart: Get.find<BadgeCart>()));
  }
}