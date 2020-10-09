import 'package:get/get.dart';

import '../../../core/properties/theme/dark_theme_controller.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/repo/cart_firebase_repo.dart';
import '../../cart/repo/i_cart_repo.dart';
import '../../cart/service/cart_service.dart';
import '../../cart/service/i_cart_service.dart';
import '../../managed_products/core/managed_products_bindings.dart';
import '../../orders/repo/i_orders_repo.dart';
import '../../orders/repo/orders_firebase_repo.dart';
import '../../orders/service/i_orders_service.dart';
import '../../orders/service/orders_service.dart';
import '../controller/overview_controller.dart';
import '../repo/i_overview_repo.dart';
import '../repo/overview_firebase_repo.dart';
import '../service/i_overview_service.dart';
import '../service/overview_service.dart';

class OverviewBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<DarkThemeController>(() => DarkThemeController());

    Get.lazyPut<IOverviewRepo>(() => OverviewFirebaseRepo());
    Get.lazyPut<IOverviewService>(() => OverviewService(
          overviewRepo: Get.find(),
          managedProductsService: Get.find(),
        ));
    Get.lazyPut<OverviewController>(
        () => OverviewController(service: Get.find()));

    Get.lazyPut<IOrdersRepo>(() => OrdersFirebaseRepo());
    Get.lazyPut<IOrdersService>(() => OrdersService());

    Get.lazyPut<ICartRepo>(() => CartFirebaseRepo());
    Get.lazyPut<ICartService>(() => CartService());
    Get.lazyPut<CartController>(() => CartController());

    ManagedProductsBindings().dependencies();
  }
}
