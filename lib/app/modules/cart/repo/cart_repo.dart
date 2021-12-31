import '../../inventory/entity/product.dart';
import '../entity/cart_item.dart';
import 'i_cart_repo.dart';

// ------------- FLUTTER ERROR: FIREBASE RULES DEADLINE/DATE EXPIRE!!! ---------------
// I/flutter ( 8038): The following _TypeError was thrown running a test:
// I/flutter ( 8038): type 'String' is not a subtype of type 'Map<String, dynamic>'
// ------------ SOLUTION: RENEW/REDATE FIREBASE RULES DEADLINE/DATE ------------------
class CartRepo implements ICartRepo {
  final Map<String, CartItem> _cartItems = {};

  @override
  Map<String, CartItem> getAllCartItems() {
    return _cartItems;
  }

  @override
  void addCartItem(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(product.id!, (item) {
        return CartItem(
          item.id,
          item.title,
          item.qtde + 1,
          item.price,
          item.imageUrl,
        );
      });
    } else {
      _cartItems.putIfAbsent(product.id!,
          () => CartItem(product.id!, product.title, 1, product.price, product.imageUrl));
    }
  }

  @override
  void addCartItemUndo(Product product) {
    var productQuantity = 0;
    _cartItems.forEach((key, value) {
      if (key == product.id) productQuantity = value.qtde;
    });
    productQuantity == 1
        ? _cartItems.remove(product.id)
        : _cartItems.update(
            product.id!,
            (item) =>
                CartItem(item.id, item.title, item.qtde - 1, item.price, item.imageUrl));
  }

  @override
  void removeCartItem(CartItem cartItem) {
    _cartItems.remove(cartItem.id);
  }

  @override
  void clearCart() {
    if (getAllCartItems().isNotEmpty) _cartItems.clear();
  }
}