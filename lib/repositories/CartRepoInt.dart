import 'package:shopingapp/entities_models/CartItem.dart';
import 'package:shopingapp/entities_models/Product.dart';

abstract class CartRepoInt {
  Map<String, CartItem> getAll();

  void addProductInTheCart(Product product);

  void undoAddProductInTheCart(Product product);

  void removeCartItem(CartItem cartItem);

  void clearCartItems();

  CartItem getById(String id);
}
