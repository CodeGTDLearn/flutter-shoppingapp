import '../order.dart';

abstract class IOrdersRepo {
  List<Order> getAllOrders();

  void addOrder(Order order);

  void clearOrdersList();
}
