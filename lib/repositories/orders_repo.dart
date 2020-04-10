import 'package:shopingapp/entities_models/order.dart';
import 'package:shopingapp/repositories/i_orders_repo.dart';

class OrdersRepo implements IOrdersRepo {
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
