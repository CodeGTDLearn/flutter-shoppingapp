import '../../cart/entities/cart_item.dart';
import '../entities/order.dart';

abstract class IOrdersService {
  Future<List<Order>> getOrders();

  int ordersQtde();

  void clearOrder();

  Future<Order> addOrder(List<CartItem> cartItemsList, double amount);

  List<Order> getLocalDataOrders();

}
