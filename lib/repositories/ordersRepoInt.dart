import '../entities/order.dart';

abstract class OrdersRepoInt {
  List<Order> getAll();

  void addOrder(Order order);

  void clearOrderList();
}
