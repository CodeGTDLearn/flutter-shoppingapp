import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../../orders/entities/order.dart';
import '../../orders/service/i_orders_service.dart';
import '../entities/cart_item.dart';
import '../service/i_cart_service.dart';

abstract class ICartController {
  Map<String, CartItem> getAllCartItems();

  void addCartItem(Product product);

  void addCartItemUndo(Product product);

  void recalcQtdeAndAmountCart();

  void removeCartItem(CartItem cartItem);

  void clearCart();

  Future<Order> addOrder(List<CartItem> cartItems, double amount);

  int getQtdeCartItemsObs();

  double getAmountCartItemsObs();
}
