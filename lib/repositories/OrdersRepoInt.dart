import 'package:shopingapp/entities_models/Order.dart';

abstract class OrdersRepoInt {
  List<Order> getAll();

  void addOrder(Order order);

  void clearOrderList();
}
