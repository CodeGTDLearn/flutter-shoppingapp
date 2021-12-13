import 'package:get/instance_manager.dart';

import '../../modules/overview/core/overview_appbar/badge_cart.dart';
import '../../modules/overview/core/overview_appbar/overview_appbar.dart';
import '../custom_widgets/custom_appbar.dart';

class CustomAppbarsBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomAppBar>(() => CustomAppBar());
    Get.lazyPut<OverviewAppBar>(() => OverviewAppBar());
    Get.lazyPut<BadgeCart>(() => BadgeCart());
  }
}