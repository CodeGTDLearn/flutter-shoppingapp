import 'package:shopingapp/entities_models/cartItem.dart';
import 'package:shopingapp/entities_models/product.dart';

abstract class CartRepoInt {
  Map<String, CartItem> getAll();

  void addProductInTheCart(Product product);

  void undoAddProductInTheCart(Product product);

  void removeCartItem(CartItem cartItem);

  void clearCartItems();

  CartItem getById(String id);
}
