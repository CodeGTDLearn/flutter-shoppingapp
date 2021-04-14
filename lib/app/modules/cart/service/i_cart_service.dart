

import '../../inventory/entities/product.dart';
import '../entities/cart_item.dart';

abstract class ICartService {
  Map<String, CartItem> getAllCartItems();

  bool addCartItem(Product product);

  bool addCartItemUndo(Product product);

  void removeCartItem(CartItem cartItem);

  double cartItemTotal$Amount();

  int cartItemsQtde();

  void clearCart();
}
