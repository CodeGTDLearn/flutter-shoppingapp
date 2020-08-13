
import '../entities/order.dart';

abstract class IOrdersRepo {
  Future<int> addOrder(Order order);

  Future<List<Order>> getAllOrders();

  void clearOrdersList();
}
