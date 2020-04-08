import 'package:shopingapp/entities_models/cart_item.dart';
import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/repositories/i_cart_repo.dart';

class CartRepo implements ICartRepo {
  Map<String, CartItem> _listCartItems = {};

  @override
  Map<String, CartItem> getAll() {
    return {..._listCartItems};
  }

  @override
  void addCartItem(Product product) {
    if (_listCartItems.containsKey(product.id)) {
      _listCartItems.update(product.id, (itemFound) {
        return CartItem(itemFound.id, itemFound.title, itemFound.qtde + 1, itemFound.price);
      });
    } else {
      _listCartItems.putIfAbsent(
          product.id, () => CartItem(product.id, product.title, 1, product.price));
    }
  }

  @override
  void removeCartItem(CartItem cartItem) {
    _listCartItems.remove(cartItem.id);
  }

  @override
  void clearCartItems() {
    if (getAll().length != 0) _listCartItems.clear();
  }

  @override
  CartItem getById(String id) {
    _listCartItems.forEach((ctx, item) {
      return item.id == id;
    });
    return null;
  }
}
