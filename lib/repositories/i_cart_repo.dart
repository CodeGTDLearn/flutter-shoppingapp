import 'package:shopingapp/entities_models/cart_item.dart';
import 'package:shopingapp/entities_models/product.dart';

abstract class ICartRepo {
  Map<String, CartItem> getAll();

  void addCartItem(Product product);

  void removeCartItem(CartItem cartItem);

  void clearCart();

  CartItem getById(String id);

  String getTotalQtdeItems();
}
