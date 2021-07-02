import '../../inventory/entities/product.dart';
import '../entities/cart_item.dart';
import 'i_cart_repo.dart';

// ------------- FLUTTER ERROR: FIREBASE RULES DEADLINE/DATE EXPIRE!!! ---------------
// I/flutter ( 8038): The following _TypeError was thrown running a test:
// I/flutter ( 8038): type 'String' is not a subtype of type 'Map<String, dynamic>'
// ------------ SOLUTION: RENEW/REDATE FIREBASE RULES DEADLINE/DATE ------------------
class CartRepoHttp implements ICartRepo {
  final Map<String, CartItem> _cartItems = {};

  @override
  Map<String, CartItem> getAllCartItems() {
    return _cartItems;
  }

  @override
  void addCartItem(Product product) {
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
      _cartItems.putIfAbsent(
          product.id, () => CartItem(product.id, product.title, 1, product.price));
    }
  }

  @override
  void addCartItemUndo(Product product) {
    var qtde = 0;
    _cartItems.forEach((key, value) {
      if (key == product.id) qtde = value.qtde;
    });
    if (qtde == 1) _cartItems.remove(product.id);
    if (qtde > 1) {
      _cartItems.update(product.id, (itemFound) {
        if (itemFound.qtde == 1) return _cartItems.remove(product.id);
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
    // if (getAllCartItems().length != 0) _cartItems.clear();
    if (getAllCartItems().isNotEmpty) _cartItems.clear();
  }
}
