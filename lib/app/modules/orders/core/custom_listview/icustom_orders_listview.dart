import 'package:flutter/widgets.dart';

import '../../../../modules/orders/entity/order.dart';

abstract class ICustomOrdersListview {
  Widget customOrdersListview(List<Order> ordersList);
}