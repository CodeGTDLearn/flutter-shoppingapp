import '../../entities/order.dart';

class OrdersFileRepo {
  final List<Order> _orders = [];

  void addOrder(Order order) {
    _orders.add(order);
  }

  void clearOrdersList() {
    _orders.clear();
  }

  Future<List<Order>> getAllOrders() async {
    return [..._orders];
  }
}
