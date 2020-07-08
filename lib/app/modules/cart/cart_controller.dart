import 'package:get/get.dart';

import '../orders/service/i_orders_service.dart';
import '../orders/service/orders_service.dart';
import './../../modules/overview/product.dart';
import 'cart_item.dart';
import 'service/cart_service.dart';
import 'service/i_cart_service.dart';

class CartController extends GetxController  {
  final ICartService _cartService = Get.put(CartService());
  final IOrdersService _ordersService = Get.put(OrdersService());

  var qtdeCartItems = 0;
  var amountCartItems = 0.0;

  Map<String, CartItem> getAll() {
    return _cartService.getAllCartItems();
  }

  void addProductInTheCart(Product product) {
    _cartService.addCartItem(product);
    recalcQtdeAndAmountCart();
  }

  void undoAddProductInTheCart(Product product) {
    _cartService.addCartItemUndo(product);
    recalcQtdeAndAmountCart();
  }

  void removeCartItem(CartItem cartItem) {
    _cartService.removeCartItem(cartItem);
    recalcQtdeAndAmountCart();
  }

  void clearCart() {
    _cartService.clearCart();
  }

  void recalcQtdeAndAmountCart() {
    qtdeCartItems = _cartService.cartItemsQtde();
    amountCartItems = _cartService.cartItemTotal$Amount();
  }

  void addOrder(List<CartItem> cartItemsList, double amount) {
    _ordersService.addOrder(cartItemsList, amount);
  }
}
