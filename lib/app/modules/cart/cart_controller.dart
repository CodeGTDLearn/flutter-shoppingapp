import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import './../../modules/overview/product.dart';
import '../orders/order.dart';
import '../orders/repo/i_orders_repo.dart';
import 'cart_item.dart';
import 'repo/i_cart_repo.dart';

part 'cart_controller.g.dart';

class CartController = _CartControllerBase with _$CartController;

abstract class _CartControllerBase with Store {
  final _cartRepo = Modular.get<ICartRepo>();
  final _orderRepo = Modular.get<IOrdersRepo>();

  @observable
  double amountCartItems = 0.0;

  @observable
  int qtdeCartItems = 0;

  @observable
  bool addProductInTheCartNotification;

  Map<String, CartItem> getAll() {
    return _cartRepo.getAll();
  }

  @action
  void addProductInTheCart(Product product) {
    _cartRepo.addProductInTheCart(product);
    calcQtdeCartItems();
    addProductInTheCartNotification = true;
  }

  @action
  void undoAddProductInTheCart(Product product) {
    _cartRepo.undoAddProductInTheCart(product);
    calcQtdeCartItems();
    addProductInTheCartNotification = false;
  }

  @action
  void removeCartItem(CartItem cartItem) {
    _cartRepo.removeCartItem(cartItem);
    calcQtdeCartItems();
    calcAmount$CartItems();
  }

  @action
  void calcAmount$CartItems() {
    var total = 0.0;
    getAll().forEach((key, cartItem) {
      total += cartItem.get_price() * cartItem.get_qtde();
    });
    amountCartItems = total;
  }

  void clearCart() {
    _cartRepo.clearCartItems();
    calcAmount$CartItems();
    calcQtdeCartItems();
  }

  void calcQtdeCartItems() {
    var totalQtde = 0;
    getAll().forEach((x, item) => totalQtde += item.get_qtde());
    qtdeCartItems = totalQtde;
  }

  void addOrder(List<CartItem> cartItemsList, double amount) {
    _orderRepo.addOrder(Order(
      DateTime.now().toString(),
      amount,
      cartItemsList,
      DateTime.now(),
    ));
  }
}
