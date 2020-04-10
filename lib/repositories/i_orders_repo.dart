import 'package:shopingapp/entities_models/order.dart';

abstract class IOrdersRepo {
  List<Order> getAll();

  void addOrder(Order order);

  void clearOrderList();
}
