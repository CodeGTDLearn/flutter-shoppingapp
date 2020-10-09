
import '../entities/order.dart';

abstract class IOrdersRepo {
  Future<Order> saveOrder(Order order);

  Future<List<Order>> getOrders();

  void clearOrders();
}
