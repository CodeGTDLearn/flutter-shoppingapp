import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:shopingapp/entities_models/CartItem.dart';
import 'package:shopingapp/repositories/CartRepoInt.dart';
import '../entities_models/Product.dart';

part 'CartStore.g.dart';

class CartStore = CartStoreInt with _$CartStore;

abstract class CartStoreInt with Store {
  final _repo = Modular.get<CartRepoInt>();

  @observable
  double totalMoneyCartItems = 0.0;

  @observable
  int totalQtdeCartItems = 0;

  Map<String, CartItem> getAll() {
    return _repo.getAll();
  }

  @action
  void addProductInTheCart(Product product) {
    _repo.addProductInTheCart(product);
    calcTotalCartQtdeItems();
  }

  @action
  void undoAddProductInTheCart(Product product) {
    _repo.undoAddProductInTheCart(product);
    calcTotalCartQtdeItems();
  }

  @action
  void removeCartItem(CartItem cartItem) {
    _repo.removeCartItem(cartItem);
    calcTotalCartQtdeItems();
    calcTotalCartMoneyAmount();
  }

  @action
  void calcTotalCartMoneyAmount() {
    double total = 0;
    getAll().forEach((key, itemCart) {
      total += itemCart.get_price() * itemCart.get_qtde();
    });
    totalMoneyCartItems = total;
  }

  void clearCartItems() {
    _repo.clearCartItems();
    calcTotalCartMoneyAmount();
    calcTotalCartQtdeItems();
    Modular.to.pop();
  }

  void calcTotalCartQtdeItems() {
    int totalQtdeItems = 0;
    getAll().forEach((x, item) => totalQtdeItems += item.get_qtde());
    totalQtdeCartItems = totalQtdeItems;
  }
}
