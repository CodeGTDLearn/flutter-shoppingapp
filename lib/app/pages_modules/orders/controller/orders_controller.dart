import 'package:get/get.dart';

import '../entities/order.dart';
import '../service/i_orders_service.dart';

class OrdersController {
  final IOrdersService service;

  var qtdeOrders = 0.obs;
  var isLoading = false.obs;

  OrdersController({this.service});

  List<Order> getOrders() {
    var orders = <Order>[];
    // @formatter:off
    service
        .getOrders()
        .then((value) {
            loadingPage();
            return value;
        })
        .catchError((onError) => throw onError);
        loadingPage();
        return orders;
    // @formatter:on
  }

  void loadingPage() {
    isLoading.value = !isLoading.value;
  }

  void clearOrders() {
    service.clearOrders();
  }
}
