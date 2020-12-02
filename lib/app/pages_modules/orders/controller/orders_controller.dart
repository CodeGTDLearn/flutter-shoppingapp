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
    ordersObs.value = [];
    // @formatter:off
    service
     .getOrders()
     .then((value) {ordersObs.value = value;})
     .catchError((onError)=> throw onError);
     return ordersObs.value;
    // @formatter:on
  }

  @override
  void clearOrders() {
    service.clearOrders();
  }

  @override
  List<Order> getOrdersObs() {
    return ordersObs.value;
  }

  @override
  int getQtdeOrdersObs() {
    return qtdeOrdersObs.value;
  }
}
