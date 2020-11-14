import '../../managed_products/entities/product.dart';
import '../entities/cart_item.dart';
import 'i_cart_repo.dart';

class CartRepo implements ICartRepo {
  final Map<String, CartItem> _cartItems = {};

  @override
  Map<String, CartItem> getAll() {
    return _cartItems;
  }

  @override
  void addProductInTheCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(product.id, (itemFound) {
        return CartItem(
          itemFound.id,
          itemFound.title,
          itemFound.qtde + 1,
          itemFound.price,
        );
      });
    } else {
      _cartItems.putIfAbsent(product.id,
          () => CartItem(product.id, product.title, 1, product.price));
    }
  }

  @override
  void undoAddProductInTheCart(Product product) {
    var qtde = 0;
    _cartItems.forEach((key, value) {
      if (key == product.id) qtde = value.qtde;
    });
    if (qtde == 1) _cartItems.remove(product.id);
    if (qtde > 1) {
      _cartItems.update(product.id, (itemFound) {
        if (itemFound.qtde == 1) _cartItems.remove(product.id);
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
    _cartItems.remove(cartItem.id);
  }

  @override
  void clearCart() {
    if (getAll().length != 0) _cartItems.clear();
  }
}
