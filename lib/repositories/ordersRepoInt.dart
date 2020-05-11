import 'package:shopingapp/entities_models/order.dart';

abstract class OrdersRepoInt {
  List<Order> getAll();

  void addOrder(Order order);

  void clearOrderList();
}
