import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/components/core_product_tile.dart';
import 'package:shopingapp/app/modules/orders/core/orders_labels.dart';

import '../../orders/service/i_orders_service.dart';
import '../controller/cart_controller.dart';
import '../repo/cart_repo_local_storage.dart';
import '../repo/i_cart_repo.dart';
import '../service/cart_service.dart';
import '../service/i_cart_service.dart';
import 'cart_icons.dart';
import 'cart_keys.dart';
import 'cart_labels.dart';

class CartBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => CartKeys());
    Get.lazyPut(() => CartLabels());
    Get.lazyPut(() => CartIcons());
    Get.lazyPut(() => CoreProductTile());
    Get.lazyPut(()=>OrdersLabels());
    // Get.lazyPut<ICartRepo>(() => CartRepoMemory());
    Get.lazyPut<ICartRepo>(() => CartRepoLocalStorage());
    Get.lazyPut<ICartService>(() => CartService(repo: Get.find<ICartRepo>()));
    Get.lazyPut(() => CartController(
        cartService: Get.find<ICartService>(),
        ordersService: Get.find<IOrdersService>()));
  }
}