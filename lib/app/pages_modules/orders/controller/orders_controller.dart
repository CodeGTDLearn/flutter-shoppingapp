import 'package:get/get.dart';

import '../entities/order.dart';
import '../service/i_orders_service.dart';
import 'i_orders_controller.dart';

class OrdersController implements IOrdersController {
  final IOrdersService service;

  var qtdeOrdersObs = 0.obs;
  var ordersObs = <Order>[].obs;

  OrdersController({this.service});

  @override
  List<Order> getOrders() {
    ordersObs.assignAll([]);
    // @formatter:off
    service
     .getOrders()
     .then((value) {ordersObs.assignAll(value);})
     .catchError((onError)=> throw onError);
     return ordersObs.toList();
    // @formatter:on
  }

  @override
  void clearOrder() {
    service.clearOrder();
  }

  @override
  List<Order> getOrdersObs() {
    return ordersObs.toList();
  }

  @override
  int getQtdeOrdersObs() {
    return qtdeOrdersObs.value;
  }
}
