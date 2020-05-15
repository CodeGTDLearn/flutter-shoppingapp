import '../entities/cartItem.dart';
import '../entities/product.dart';
import '../repositories/cartRepoInt.dart';

class CartRepo implements CartRepoInt {
  Map<String, CartItem> _listCartItems = {};

  @override
  Map<String, CartItem> getAll() {
    return {..._listCartItems};
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
      _listCartItems.putIfAbsent(product.get_id(),
          () => CartItem(product.get_id(), product.get_title(), 1, product.get_price()));
    }
  }

  @override
  void undoAddProductInTheCart(Product product) {
    if (_listCartItems.containsKey(product.get_id())) {
      _listCartItems.update(product.get_id(), (itemFound) {
        return CartItem(
          itemFound.get_id(),
          itemFound.get_title(),
          itemFound.get_qtde() - 1,
          itemFound.get_price(),
        );
      });
    } else {
      _listCartItems.remove(product.get_id());
    }
  }

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
