


import '../../cart/entities/cart_item.dart';
import '../entities/order.dart';

abstract class IOrdersService {
  List<Order> getAllOrders();

//  int ordersQtde();

  void clearOrders();

  void addOrder(List<CartItem> cartItemsList, double amount);
}
