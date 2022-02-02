import 'package:flutter/widgets.dart';

import '../../../entity/order.dart';

abstract class ICustomOrdersListview {
  Widget ordersListview(List<Order> orders);
}