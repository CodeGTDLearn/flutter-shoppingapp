import 'package:get/state_manager.dart';

import '../entity/order.dart';
import '../service/i_orders_service.dart';

class OrdersController {
  final IOrdersService service;

  var qtdeOrdersObs = 0.obs;
  var ordersObs = <Order>[].obs;
  var isTileCollapsed = false.obs;

  OrdersController({required this.service});

  List<Order> getOrders() {
    ordersObs.assignAll([]);
    // @formatter:off
    service.getOrders().then((value) {
      ordersObs.assignAll(value);
    }).catchError((onError) => throw onError);
    return ordersObs.toList();
    // @formatter:on
  }

  void clearOrder() {
    service.clearOrder();
  }

  void toggleCollapseTile() {
    isTileCollapsed.value = !isTileCollapsed.value;
  }
}