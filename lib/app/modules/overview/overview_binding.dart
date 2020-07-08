import 'package:get/get.dart';

import '../cart/cart_controller.dart';
import 'components/overview_item/overview_item_controller.dart';
import 'overview_controller.dart';

class OverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OverviewController>(() => OverviewController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<OverviewItemController>(() => OverviewItemController());
  }
}
