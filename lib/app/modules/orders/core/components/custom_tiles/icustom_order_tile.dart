import 'package:flutter/widgets.dart';

import '../../../entity/order.dart';

abstract class ICustomOrderTile {
  Widget create(Order order);
}