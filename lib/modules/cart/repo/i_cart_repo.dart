import '../../core/entities/cart_item.dart';
import '../../core/entities/product.dart';

abstract class ICartRepo {
  Map<String, CartItem> getAll();

  void addProductInTheCart(Product product);

  void undoAddProductInTheCart(Product product);

  void removeCartItem(CartItem cartItem);

  void clearCartItems();
}
//  CartItem getById(String id);
