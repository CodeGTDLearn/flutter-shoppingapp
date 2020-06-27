import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';

import '../../modules/cart/cart_item.dart';
import 'order.dart';

part 'orders_controller.g.dart';

class OrdersController = _OrdersControllerBase with _$OrdersController;

abstract class _OrdersControllerBase with Store {
  final _service = Modular.get<IOrdersService>();

  @observable
  int qtdeOrders = 0;

  List<Order> getAllOrders() {
    return _service.getAllOrders();
  }

  void clearOrders() {
    _service.clearOrders();
  }

  void addOrder(List<CartItem> cartItemsList, double amount) {
    _service.addOrder(cartItemsList, amount);
    qtdeOrders = getAllOrders().length;
  }
}
