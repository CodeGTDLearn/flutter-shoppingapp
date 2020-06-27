import '../order.dart';

abstract class IOrdersRepo {
  List<Order> getAll();

  void addOrder(Order order);

  void clearOrderList();
}
