import '../../cart/entity/cart_item.dart';
import '../entity/order.dart';

abstract class IOrdersService {
  Future<List<Order>> getOrders();

  int ordersQtde();

  void clearOrder();

  Future<Order> addOrder(List<CartItem> cartItemsList, double amount);

  List<Order> getLocalDataOrders();
}
