import 'package:get/get.dart';
import '../../cart/cart_controller.dart';
import '../../cart/repo/cart_firebase_repo.dart';
import '../../cart/repo/i_cart_repo.dart';
import '../../cart/service/cart_service.dart';
import '../../cart/service/i_cart_service.dart';
import '../../orders/service/i_orders_service.dart';
import '../../orders/service/orders_service.dart';


class Cart {
  static void dependencies() {
    Get.lazyPut<ICartService>(() => CartService());
    Get.lazyPut<ICartRepo>(() => CartFirebaseRepo());
    Get.lazyPut<IOrdersService>(() => OrdersService());
    Get.lazyPut<CartController>(() => CartController());
  }
}
