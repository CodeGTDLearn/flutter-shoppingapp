import '../../overview/product.dart';
import '../cart_item.dart';

abstract class ICartRepo {
  Map<String, CartItem> getAll();

  void addProductInTheCart(Product product);

  void undoAddProductInTheCart(Product product);

  void removeCartItem(CartItem cartItem);

  void clearCartItems();

  CartItem getById(String id);
}
