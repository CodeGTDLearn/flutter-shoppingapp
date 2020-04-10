import 'package:shopingapp/entities_models/order.dart';
import 'package:shopingapp/repositories/i_orders_repo.dart';

class OrdersRepo implements IOrdersRepo {
  List<Order> orders = [];
}
