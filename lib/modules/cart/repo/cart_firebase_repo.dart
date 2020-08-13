

import '../../managed_products/entities/product.dart';
import '../entities/cart_item.dart';
import 'i_cart_repo.dart';

class CartFirebaseRepo implements ICartRepo {
  final Map<String, CartItem> _listCartItems = {};

  @override
  Map<String, CartItem> getAll() {
    return _listCartItems;
  }

  @override
  void addProductInTheCart(Product product) {
    if (_listCartItems.containsKey(product.id)) {
      _listCartItems.update(product.id, (itemFound) {
        return CartItem(
          itemFound.id,
          itemFound.title,
          itemFound.qtde + 1,
          itemFound.price,
        );
      });
    } else {
      _listCartItems.putIfAbsent(
          product.id,
          () => CartItem(
              product.id, product.title, 1, product.price));
    }
  }

  @override
  void undoAddProductInTheCart(Product product) {
    var qtde = 0;
    _listCartItems.forEach((key, value) {
      if (key == product.id) qtde = value.qtde;
    });
    if (qtde == 1) _listCartItems.remove(product.id);
    if (qtde > 1) {
      _listCartItems.update(product.id, (itemFound) {
        if (itemFound.qtde == 1) _listCartItems.remove(product.id);
        return CartItem(
          itemFound.id,
          itemFound.title,
          itemFound.qtde - 1,
          itemFound.price,
        );
      });
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
}
//
//  @override
//  CartItem getById(String id) {
//    _listCartItems.forEach((ctx, item) {
//      return item.id == id;
//    });
//    return null;
//  }
