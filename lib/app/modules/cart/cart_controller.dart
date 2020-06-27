import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import './../../modules/overview/product.dart';
import '../orders/service/i_orders_service.dart';
import 'cart_item.dart';
import 'service/i_cart_service.dart';

part 'cart_controller.g.dart';

class CartController = _CartControllerBase with _$CartController;

abstract class _CartControllerBase with Store {
  final _cartService = Modular.get<ICartService>();
  final _ordersService = Modular.get<IOrdersService>();

  @observable
  double amountCartItems = 0.0;

  @observable
  int qtdeCartItems = 0;

  Map<String, CartItem> getAll() {
    return _cartService.getAllCartItems();
  }

  @action
  void addProductInTheCart(Product product) {
    _cartService.addCartItem(product);
    recalcQtdeAndAmountCart();
  }

  @action
  void undoAddProductInTheCart(Product product) {
    _cartService.addCartItemUndo(product);
    recalcQtdeAndAmountCart();
  }

  @action
  void removeCartItem(CartItem cartItem) {
    _cartService.removeCartItem(cartItem);
    recalcQtdeAndAmountCart();
  }

  @action
  void clearCart() {
    _cartService.clearCart();
    recalcQtdeAndAmountCart();
  }

  void recalcQtdeAndAmountCart() {
    qtdeCartItems = _cartService.cartItemsQtde();
    amountCartItems = _cartService.cartItemTotal$Amount();
  }

  void addOrder(List<CartItem> cartItemsList, double amount) {
    _ordersService.addOrder(cartItemsList, amount);
  }
}
