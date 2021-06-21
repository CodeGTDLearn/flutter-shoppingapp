import 'package:get/get.dart';

import '../../orders/service/i_orders_service.dart';
import '../controller/cart_controller.dart';
import '../repo/cart_repo_http.dart';
import '../repo/i_cart_repo.dart';
import '../service/cart_service.dart';
import '../service/i_cart_service.dart';

class CartBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<ICartRepo>(() => CartRepoHttp());

    Get.lazyPut<ICartService>(() => CartService(repo: Get.find<ICartRepo>()));

    Get.lazyPut<CartController>(() => CartController(
          cartService: Get.find<ICartService>(),
          ordersService: Get.find<IOrdersService>(),
        ));
  }
}
