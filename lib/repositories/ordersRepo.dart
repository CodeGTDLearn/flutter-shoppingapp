import '../entities/order.dart';
import '../repositories/ordersRepoInt.dart';

class OrdersRepo implements OrdersRepoInt {
  List<Order> _orders = [];

  @override
  List<Order> getAll() {
    return [..._orders];
  }

  @override
  void addOrder(Order order) {
    _orders.add(order);
  }

  @override
  void clearOrderList(){
    _orders.clear();
  }
}
