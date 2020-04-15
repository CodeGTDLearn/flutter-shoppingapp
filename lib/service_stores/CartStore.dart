import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:shopingapp/entities_models/cart_item.dart';
import 'package:shopingapp/repositories/i_cart_repo.dart';
import '../entities_models/product.dart';

part 'CartStore.g.dart';

class CartStore = ICartStore with _$CartStore;

abstract class ICartStore with Store {
  final _repo = Modular.get<ICartRepo>();

  @observable
  double totalMoneyCartItems = 0.0;

  @observable
  int totalQtdeCartItems = 0;

  Map<String, CartItem> getAll() {
    return _repo.getAll();
  }

  @action
  void addCartItem(Product product) {
    _repo.addCartItem(product);
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
      total += itemCart.price * itemCart.qtde;
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
    getAll().forEach((x, item) => totalQtdeItems += item.qtde);
    totalQtdeCartItems = totalQtdeItems;
  }
}
