import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/custom_widgets/custom_appbar.dart';

import '../../orders/service/i_orders_service.dart';
import '../controller/cart_controller.dart';
import '../repo/i_cart_repo.dart';
import '../service/cart_service.dart';
import '../service/i_cart_service.dart';

class CartBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomAppBar>(() => CustomAppBar());

    // Get.put<ICartRepo>(CartRepo(), permanent: true, tag: 'cartRepo');

    Get.lazyPut<ICartService>(() => CartService(
          repo: Get.find<ICartRepo>(tag: 'cartRepo'),
        ));

    Get.lazyPut<CartController>(() => CartController(
          cartService: Get.find<ICartService>(),
          ordersService: Get.find<IOrdersService>(),
        ));
  }
}