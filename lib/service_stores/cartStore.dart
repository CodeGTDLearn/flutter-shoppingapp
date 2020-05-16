import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../entities/cartItem.dart';
import '../repositories/cartRepoInt.dart';
import '../entities/product.dart';

part 'cartStore.g.dart';

class CartStore = CartStoreInt with _$CartStore;

abstract class CartStoreInt with Store {
  final _repo = Modular.get<CartRepoInt>();

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
    getAll().forEach((key, itemCart) {
      total += itemCart.get_price() * itemCart.get_qtde();
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
