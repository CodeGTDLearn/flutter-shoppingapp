import '../entities/order.dart';

abstract class IOrdersController {
  List<Order> getOrders();

  void clearOrder();

  List<Order> getOrdersObs();

  int getQtdeOrdersObs();
}
