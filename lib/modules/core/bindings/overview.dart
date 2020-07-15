import 'package:get/get.dart';

import '../../cart/cart_controller.dart';
import '../../cart/service/cart_service.dart';
import '../../cart/service/i_cart_service.dart';
import '../../managed_products/services/i_managed_products_service.dart';
import '../../managed_products/services/managed_products_service.dart';
import '../../orders/service/i_orders_service.dart';
import '../../orders/service/orders_service.dart';
import '../../overview/components/overview_item/overview_item_controller.dart';
import '../../overview/overview_controller.dart';
import '../../overview/repo/i_overview_repo.dart';
import '../../overview/repo/overview_firebase_repo.dart';
import '../../overview/service/i_overview_service.dart';
import '../../overview/service/overview_service.dart';
import '../theme/dark_theme_controller.dart';

class Overview {
  static void dependencies() {
    Get.lazyPut<IOverviewService>(() => OverviewService());
    Get.lazyPut<IOverviewRepo>(() => OverviewFirebaseRepo());
    Get.lazyPut<OverviewController>(() => OverviewController());
    Get.lazyPut<OverviewItemController>(() => OverviewItemController());

    Get.lazyPut<ICartService>(() => CartService());
    Get.lazyPut<IOrdersService>(() => OrdersService());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<DarkThemeController>(() => DarkThemeController());
    Get.lazyPut<IManagedProductsService>(() => ManagedProductsService());
  }
}
