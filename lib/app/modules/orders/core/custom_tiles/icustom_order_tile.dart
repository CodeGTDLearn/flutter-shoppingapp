import 'package:flutter/widgets.dart';

import '../../../../modules/orders/entity/order.dart';

abstract class ICustomOrderTile {
  Widget create(Order order);
}