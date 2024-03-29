import '../../inventory/entity/product.dart';
import '../entity/cart_item.dart';

abstract class ICartService {
  Map<String, CartItem> getAllCartItems();

  Map<String, CartItem> getAllAvailableCartItems(Map<String, CartItem> carItems);

  bool addCartItem(Product product);

  bool addCartItemUndo(Product product);

  void removeCartItem(CartItem cartItem);

  void removeCartItemById(String cartItemId);

  double amountCartItems(Map<String, CartItem> carItems);

  int qtdeCartItems(Map<String, CartItem> carItems);

  int getCartItemQtdeById(String cartItemId);

  CartItem getCartItemById(String cartItemId);

  void clearCart();
}