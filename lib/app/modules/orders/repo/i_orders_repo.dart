import '../entities/order.dart';

abstract class IOrdersRepo {
  Future<Order> addOrder(Order order);

  Future<List<Order>> getOrders();
}
