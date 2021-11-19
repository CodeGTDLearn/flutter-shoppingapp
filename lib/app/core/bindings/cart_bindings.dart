import 'package:get/get.dart';

import '../../modules/cart/controller/cart_controller.dart';
import '../../modules/cart/repo/cart_repo_firebase.dart';
import '../../modules/cart/repo/i_cart_repo.dart';
import '../../modules/cart/service/cart_service.dart';
import '../../modules/cart/service/i_cart_service.dart';
import '../../modules/orders/service/i_orders_service.dart';

class CartBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<ICartRepo>(() => CartRepoFirebase());

    Get.lazyPut<ICartService>(() => CartService(repo: Get.find<ICartRepo>()));

    Get.lazyPut<CartController>(() => CartController(
          cartService: Get.find<ICartService>(),
          ordersService: Get.find<IOrdersService>(),
        ));
  }
}