import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/entities_models/cart_item.dart';
import 'package:shopingapp/entities_models/order.dart';
import 'package:shopingapp/repositories/i_orders_repo.dart';

part 'OrdersStore.g.dart';

class OrdersStore = IOrdersStore with _$OrdersStore;

abstract class IOrdersStore with Store {
  final _repo = Modular.get<IOrdersRepo>();

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
