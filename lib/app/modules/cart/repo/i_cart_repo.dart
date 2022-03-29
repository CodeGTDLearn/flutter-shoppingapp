import '../../inventory/entity/product.dart';
import '../entity/cart_item.dart';

abstract class ICartRepo {
  Map<String, CartItem> getAllCartItems();

  void addCartItem(Product product);

  void addCartItemUndo(Product product);

  void removeCartItem(CartItem cartItem);

  void removeCartItemById(String cartItemId);

  int getCartItemQtdeById(String cartItemId);

  CartItem getCartItemById(String cartItemId);

  void clearCart();
}