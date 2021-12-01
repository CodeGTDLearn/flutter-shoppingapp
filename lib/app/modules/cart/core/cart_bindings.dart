import 'package:get/instance_manager.dart';

import '../../orders/service/i_orders_service.dart';
import '../controller/cart_controller.dart';
import '../repo/i_cart_repo.dart';
import '../service/cart_service.dart';
import '../service/i_cart_service.dart';

class CartBindings extends Bindings {
  void dependencies() {
    final _permanentCartRepo = Get.find<ICartRepo>(tag: 'persistentCartRepo');

    Get.lazyPut<ICartService>(() => CartService(repo: _permanentCartRepo));

    Get.lazyPut<CartController>(() => CartController(
        cartService: Get.find<ICartService>(),
        ordersService: Get.find<IOrdersService>()));
  }
}