import '../../../core/entities/order.dart';
import '../i_orders_repo.dart';

class OrdersFileRepo{
  final List<Order> _orders = [];

  @override
  Future<int> addOrder(Order order) {
    _orders.add(order);
    return null;
  }

  @override
  void clearOrdersList() {
    _orders.clear();
  }

  @override
  Future<List<Order>> getAllOrders() async {
    return [..._orders];
  }
}
