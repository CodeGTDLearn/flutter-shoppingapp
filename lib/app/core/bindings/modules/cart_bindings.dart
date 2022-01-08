import 'package:get/instance_manager.dart';

import '../../../modules/cart/controller/cart_controller.dart';
import '../../../modules/cart/repo/cart_repo.dart';
import '../../../modules/cart/repo/i_cart_repo.dart';
import '../../../modules/cart/service/cart_service.dart';
import '../../../modules/cart/service/i_cart_service.dart';
import '../../../modules/orders/service/i_orders_service.dart';
import '../../icons/modules/cart_icons.dart';
import '../../keys/modules/cart_keys.dart';
import '../../labels/modules/cart_labels.dart';

class CartBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => CartKeys());
    Get.lazyPut(() => CartLabels());
    Get.lazyPut(() => CartIcons());
    Get.lazyPut<ICartRepo>(() => CartRepo());
    Get.lazyPut<ICartService>(() => CartService(repo: Get.find<ICartRepo>()));
    Get.lazyPut(() => CartController(
        cartService: Get.find<ICartService>(),
        ordersService: Get.find<IOrdersService>()));
  }
}