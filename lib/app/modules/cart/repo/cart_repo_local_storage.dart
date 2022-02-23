import 'package:get/instance_manager.dart';

import '../../../core/local_storage/local_storage_controller.dart';
import '../../inventory/entity/product.dart';
import '../entity/cart_item.dart';
import 'i_cart_repo.dart';

class CartRepoLocalStorage implements ICartRepo {
  final _localStorage = Get.find<LocalStorageController>();
  Map<String, CartItem> _cartItems = {};

  @override
  Map<String, CartItem> getAllCartItems() {
    _cartItems = _localStorage.getCartItemsLocalStorage();
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
    _localStorage.saveCartItemsLocalStorage(_cartItems);
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
    _localStorage.saveCartItemsLocalStorage(_cartItems);
  }

  @override
  void removeCartItem(CartItem cartItem) {
    _cartItems.remove(cartItem.id);
    _localStorage.saveCartItemsLocalStorage(_cartItems);
  }

  @override
  void clearCart() {
    if (getAllCartItems().isNotEmpty) _cartItems.clear();
    _localStorage.clearCartItemsLocalStorage();
  }
}