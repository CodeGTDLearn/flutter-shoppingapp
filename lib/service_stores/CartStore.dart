import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/entities_models/cart_item.dart';
import 'package:shopingapp/repositories/i_cart_repo.dart';

part 'CartStore.g.dart';

class CartStore = ICartStore with _$CartStore;

abstract class ICartStore with Store {
  final _repo = Modular.get<ICartRepo>();

  Map<String, CartItem> getAll() {
    return _repo.getAll();
  }

  String getTotalCartAmount() {
    double total;
    getAll().forEach((key, itemCart) {
      total += itemCart.price * itemCart.qtde;
    });
    return total == null ? '00.00' : total.toStringAsFixed(2);
  }
}
