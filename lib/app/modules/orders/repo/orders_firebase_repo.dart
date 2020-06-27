import '../order.dart';
import 'i_orders_repo.dart';

class OrdersFirebaseRepo implements IOrdersRepo {
  final List<Order> _orders = [];

  @override
  List<Order> getAllOrders() {
    return [..._orders];
  }

  @override
  void addOrder(Order order) {
    _orders.add(order);
  }

  @override
  void clearOrdersList() {
    _orders.clear();
  }
}
