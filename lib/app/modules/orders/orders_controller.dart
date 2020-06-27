import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../modules/cart/cart_item.dart';
import 'order.dart';
import 'repo/i_orders_repo.dart';

part 'orders_controller.g.dart';

class OrdersController = _OrdersControllerBase with _$OrdersController;

abstract class _OrdersControllerBase with Store {
  final _repo = Modular.get<IOrdersRepo>();

  @observable
  int qtdeOrders = 0;

  List<Order> getAll() {
    return _repo.getAll();
  }

  void clearOrders() {
    _repo.clearOrderList();
  }

  void addOrder(List<CartItem> cartItemsList, double amount) {
    _repo.addOrder(Order(
      DateTime.now().toString(),
      amount,
      cartItemsList,
      DateTime.now(),
    ));
    qtdeOrders = getAll().length;
  }
}
