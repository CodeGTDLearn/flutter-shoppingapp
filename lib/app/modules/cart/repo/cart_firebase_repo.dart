import '../../overview/product.dart';
import '../cart_item.dart';
import 'i_cart_repo.dart';

class CartFirebaseRepo implements ICartRepo {
  final Map<String, CartItem> _listCartItems = {};

  @override
  Map<String, CartItem> getAll() {
    return _listCartItems;
  }

  @override
  void addProductInTheCart(Product product) {
    if (_listCartItems.containsKey(product.get_id())) {
      _listCartItems.update(product.get_id(), (itemFound) {
        return CartItem(
          itemFound.get_id(),
          itemFound.get_title(),
          itemFound.get_qtde() + 1,
          itemFound.get_price(),
        );
      });
    } else {
      _listCartItems.putIfAbsent(
          product.get_id(),
          () => CartItem(
              product.get_id(), product.get_title(), 1, product.get_price()));
    }
  }

  @override
  void undoAddProductInTheCart(Product product) {
    var qtde = 0;
    _listCartItems.forEach((key, value) {
      if (key == product.get_id()) qtde = value.get_qtde();
    });
    if (qtde == 1) _listCartItems.remove(product.get_id());
    if (qtde > 1) {
      _listCartItems.update(product.get_id(), (itemFound) {
        if (itemFound.get_qtde() == 1) _listCartItems.remove(product.get_id());
        return CartItem(
          itemFound.get_id(),
          itemFound.get_title(),
          itemFound.get_qtde() - 1,
          itemFound.get_price(),
        );
      });
    }
  }

//    if (_listCartItems.containsKey(product.get_id())) {
//      _listCartItems.update(product.get_id(), (itemFound) {
//        return EntityCartItem(
//          itemFound.get_id(),
//          itemFound.get_title(),
//          itemFound.get_qtde() - 1,
//          itemFound.get_price(),
//        );
//      });
//    } else {
//      _listCartItems.remove(product.get_id());
//    }
//}

  @override
  void removeCartItem(CartItem cartItem) {
    _listCartItems.remove(cartItem.get_id());
  }

  @override
  void clearCartItems() {
    if (getAll().length != 0) _listCartItems.clear();
  }

  @override
  CartItem getById(String id) {
    _listCartItems.forEach((ctx, item) {
      return item.get_id() == id;
    });
    return null;
  }
}
