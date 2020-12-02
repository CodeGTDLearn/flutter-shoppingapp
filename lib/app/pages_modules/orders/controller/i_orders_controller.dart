import '../entities/order.dart';

abstract class IOrdersController {
  List<Order> getOrders();

  void clearOrders();

  List<Order> getOrdersObs();

  int getQtdeOrdersObs();
}
