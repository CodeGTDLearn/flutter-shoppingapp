import '../../cart/cart_item.dart';
import '../order.dart';

abstract class IOrdersService {
  List<Order> getAllOrders();

  int ordersQtde();

  void clearOrders();

  void addOrder(List<CartItem> cartItemsList, double amount);
}
