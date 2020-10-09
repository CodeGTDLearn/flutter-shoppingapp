import 'package:get/get.dart';

import '../entities/order.dart';
import '../service/i_orders_service.dart';

class OrdersController {
  final IOrdersService service;

  var qtdeOrders = 0.obs;

  OrdersController({this.service});

  List<Order> getAllOrders() {
    return service.getOrders();
  }

  void clearOrders() {
    service.clearOrders();
  }

//  void addOrder(List<CartItem> cartItemsList, double amount) {
//    _service.addOrder(cartItemsList, amount);
//    qtdeOrders.value = getAllOrders().length;
//  }
}
