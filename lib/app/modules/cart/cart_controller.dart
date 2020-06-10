import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/app/modules/cart/cart_repo.dart';
import 'package:shopingapp/app/modules/overview/product.dart';

import 'cart_item.dart';

part 'cart_controller.g.dart';

class CartController = CartControllerBase with _$CartController;

abstract class CartControllerBase with Store {
  final _repo = Modular.get<CartRepo>();

  @observable
  double amountCartItems = 0.0;

  @observable
  int qtdeCartItems = 0;

  @observable
  bool addProductInTheCartNotification;

  Map<String, CartItem> getAll() {
    return _repo.getAll();
  }

  @action
  void addProductInTheCart(Product product) {
    _repo.addProductInTheCart(product);
    calcQtdeCartItems();
    addProductInTheCartNotification = true;
  }

  @action
  void undoAddProductInTheCart(Product product) {
    _repo.undoAddProductInTheCart(product);
    calcQtdeCartItems();
    addProductInTheCartNotification = false;
  }

  @action
  void removeCartItem(CartItem cartItem) {
    _repo.removeCartItem(cartItem);
    calcQtdeCartItems();
    calcAmount$CartItems();
  }

  @action
  void calcAmount$CartItems() {
    double total = 0;
    getAll().forEach((key, cartItem) {
      total += cartItem.get_price() * cartItem.get_qtde();
    });
    amountCartItems = total;
  }

  void clearCart() {
    _repo.clearCartItems();
    calcAmount$CartItems();
    calcQtdeCartItems();
    Modular.to.pop();
  }

  void calcQtdeCartItems() {
    int totalQtde = 0;
    getAll().forEach((x, item) => totalQtde += item.get_qtde());
    qtdeCartItems = totalQtde;
  }
}
