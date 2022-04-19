import 'package:get/instance_manager.dart';

import '../../inventory/entity/product.dart';
import '../../inventory/service/i_inventory_service.dart';
import '../entity/cart_item.dart';
import '../repo/i_cart_repo.dart';
import 'i_cart_service.dart';

class CartService implements ICartService {
  final ICartRepo repo;
  final _service = Get.find<IInventoryService>();

  CartService({required this.repo});

  Map<String, CartItem> getAllCartItems() {
    return repo.getAllCartItems();
  }

  bool addCartItem(Product product) {
    repo.addCartItem(product);
    return true;
  }

  bool addCartItemUndo(Product product) {
    repo.addCartItemUndo(product);
    return false;
  }

  void removeCartItem(CartItem cartItem) {
    repo.removeCartItem(cartItem);
  }

  void removeCartItemById(String cartItemId) {
    repo.removeCartItemById(cartItemId);
  }

  void clearCart() {
    repo.clearCart();
  }

  double amountCartItems(Map<String, CartItem> cartItems) {
    var total = 0.0;
    var _cartItemTotalDiscount = 0.0;
    var _availableCartIitems = getAllAvailableCartItems(cartItems);

    _availableCartIitems.forEach((key, cartItem) {
      var _totalPriceNoDiscount = cartItem.price * cartItem.qtde;
      if(cartItem.discount != 0){
        var _individualDiscount = cartItem.price * (cartItem.discount / 100);
        _cartItemTotalDiscount = _individualDiscount * cartItem.qtde;
      }
      total += _totalPriceNoDiscount - _cartItemTotalDiscount;
    });
    return total;
  }

  int qtdeCartItems(Map<String, CartItem> cartItems) {
    var totalQtde = 0;
    cartItems.forEach((x, item) => totalQtde += item.qtde);
    return totalQtde;
  }

  @override
  Map<String, CartItem> getAllAvailableCartItems(Map<String, CartItem> carItems) {
    var availableCartItems = <String, CartItem>{};
    carItems.forEach((key, cartItem) {
      var available = _service.checkItemAvailability(cartItem.id);
      if (available) availableCartItems.putIfAbsent(key, () => cartItem);
    });
    return availableCartItems;
  }

  @override
  int getCartItemQtdeById(String cartItemId) {
    return repo.getCartItemQtdeById(cartItemId);
  }

  @override
  CartItem getCartItemById(String cartItemId) {
    return repo.getCartItemById(cartItemId);
  }
}