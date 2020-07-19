import 'package:get/get.dart';

import '../cart/cart_controller.dart';
import '../cart/repo/cart_firebase_repo.dart';
import '../cart/repo/i_cart_repo.dart';
import '../cart/service/cart_service.dart';
import '../cart/service/i_cart_service.dart';
import '../core/configurable/theme/dark_theme_controller.dart';
import '../managed_products/services/i_managed_products_service.dart';
import '../managed_products/services/managed_products_service.dart';
import '../orders/repo/i_orders_repo.dart';
import '../orders/repo/orders_firebase_repo.dart';
import '../orders/service/i_orders_service.dart';
import '../orders/service/orders_service.dart';
import 'components/overview_item/overview_item_controller.dart';
import 'overview_controller.dart';
import 'repo/i_overview_repo.dart';
import 'repo/overview_firebase_repo.dart';
import 'service/i_overview_service.dart';
import 'service/overview_service.dart';


class OverviewBindings  extends Bindings {
  void dependencies() {
    Get.lazyPut<DarkThemeController>(() => DarkThemeController());

    Get.lazyPut<IOverviewRepo>(() => OverviewFirebaseRepo());
    Get.lazyPut<IOverviewService>(() => OverviewService());
    Get.lazyPut<OverviewController>(() => OverviewController());
    Get.lazyPut<OverviewItemController>(() => OverviewItemController());

    Get.lazyPut<IOrdersRepo>(() => OrdersFirebaseRepo());
    Get.lazyPut<IOrdersService>(() => OrdersService());

    Get.lazyPut<ICartRepo>(() => CartFirebaseRepo());
    Get.lazyPut<ICartService>(() => CartService());
    Get.lazyPut<CartController>(() => CartController());

    Get.lazyPut<IManagedProductsService>(() => ManagedProductsService());
  }
}
