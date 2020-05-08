import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/entities_models/CartItem.dart';
import 'package:shopingapp/entities_models/Order.dart';
import 'package:shopingapp/repositories/OrdersRepoInt.dart';

part 'OrdersStore.g.dart';

class OrdersStore = OrdersStoreInt with _$OrdersStore;

abstract class OrdersStoreInt with Store {
  final _repo = Modular.get<OrdersRepoInt>();

  @observable
  int totalOrders = 0;

  List<Order> getAll() {
    return _repo.getAll();
  }

  void clearOrderList() {
    _repo.clearOrderList();
  }

  void addOrder(List<CartItem> cartItemsList, double amount) {
    _repo.addOrder(Order(
      DateTime.now().toString(),
      amount,
      cartItemsList,
      DateTime.now(),
    ));
    totalOrders = getAll().length;
  }
}
