import 'package:get/get.dart';

import '../core/entities/cart_item.dart';
import '../core/entities/order.dart';
import 'service/i_orders_service.dart';

class OrdersController {
  final IOrdersService _service = Get.find();

  var qtdeOrders = 0.obs;

  Future<int> getAllOrders() {
    return _service.getAllOrders().asStream().length;
  }

  void clearOrders() {
    _service.clearOrders();
  }

//  void addOrder(List<CartItem> cartItemsList, double amount) {
//    _service.addOrder(cartItemsList, amount);
//    qtdeOrders.value = getAllOrders().length;
//  }
}
