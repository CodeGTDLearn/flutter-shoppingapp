import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../entities/cartItem.dart';
import '../entities/order.dart';
import '../repositories/ordersRepoInt.dart';

part 'ordersStore.g.dart';

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
