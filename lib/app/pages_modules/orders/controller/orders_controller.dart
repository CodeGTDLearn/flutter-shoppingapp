import 'package:get/get.dart';

import '../entities/order.dart';
import '../service/i_orders_service.dart';

class OrdersController {
  final IOrdersService service;

  var qtdeOrders = 0.obs;
  var ordersObs = <Order>[].obs;

  OrdersController({this.service});

  List<Order> getOrders() {
    ordersObs.value = [];
    // @formatter:off
     service
        .getOrders()
        .then((value) {
            ordersObs.value = value;
            // return value;
        })
        .catchError((onError) => throw onError);
        return ordersObs.value;
    // @formatter:on
  }

  void clearOrders() {
    service.clearOrders();
  }
}
