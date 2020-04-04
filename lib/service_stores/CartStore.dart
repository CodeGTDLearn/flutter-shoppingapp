import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:shopingapp/entities_models/cart_item.dart';
import 'package:shopingapp/repositories/i_cart_repo.dart';
import 'package:shopingapp/widgets/flushNotifier.dart';
import '../entities_models/product.dart';

part 'CartStore.g.dart';

class CartStore = ICartStore with _$CartStore;

abstract class ICartStore with Store {
  final _repo = Modular.get<ICartRepo>();

  @observable
  String totalCartItems = "0";

  Map<String, CartItem> getAll() {
    return _repo.getAll();
  }

  @action
  void addCartItem(Product product) {
    _repo.addCartItem(product);
    totalCartItems = _repo.getTotalQtdeItems();
  }

  @action
  void removeCartItem(Product product) {
    if (_repo.getById(product.id) != null) {
      _repo.removeCartItem(product);
    } else {
      FlushNotifier('Ops...', 'Product not found.', 2000);
    }
  }

  String getTotalCartAmount() {
    double total = 0;
    getAll().forEach((key, itemCart) {
      total += itemCart.price * itemCart.qtde;
    });
    return total == null ? '00.00' : total.toStringAsFixed(2);
  }

  void clearCart() {
    _repo.clearCart;
  }
}
