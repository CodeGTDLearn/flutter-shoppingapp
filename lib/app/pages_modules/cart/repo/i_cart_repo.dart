

import '../../managed_products/entities/product.dart';
import '../entities/cart_item.dart';

abstract class ICartRepo {
  Map<String, CartItem> getAll();

  void addProductInTheCart(Product product);

  void undoAddProductInTheCart(Product product);

  void removeCartItem(CartItem cartItem);

  void clearCart();
}
//  CartItem getById(String id);
