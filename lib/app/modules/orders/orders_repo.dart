import 'order.dart';

class OrdersRepo {
  List<Order> _orders = [];

  List<Order> getAll() {
    return [..._orders];
  }

  void addOrder(Order order) {
    _orders.add(order);
  }

  void clearOrderList() {
    _orders.clear();
  }
}
