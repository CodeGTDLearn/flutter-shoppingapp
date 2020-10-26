import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../repo/cart_firebase_repo.dart';
import '../repo/i_cart_repo.dart';
import '../service/cart_service.dart';
import '../service/i_cart_service.dart';

class CartBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<ICartRepo>(() => CartFirebaseRepo());

    Get.lazyPut<ICartService>(() => CartService(repo: Get.find()));

    Get.lazyPut<CartController>(() => CartController(
          cartService: Get.find(),
          ordersService: Get.find(),
        ));
  }
}
