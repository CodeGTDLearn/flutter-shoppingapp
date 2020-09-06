

import '../../entities/order.dart';

class OrdersFileRepo {
  final List<Order> _orders = [];

  Future<int> addOrder(Order order) {
    _orders.add(order);
    return null;
  }

  void clearOrdersList() {
    _orders.clear();
  }

  Future<List<Order>> getAllOrders() async {
    return [..._orders];
  }
}
