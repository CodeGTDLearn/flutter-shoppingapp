import 'package:flutter/material.dart';

import '../../../../modules/orders/entity/order.dart';
import '../custom_tiles/collapsable_tile.dart';
import 'icustom_orders_listview.dart';

class SimpleListview implements ICustomOrdersListview {
  @override
  Widget ordersListview(List<Order> ordersList) {
    return ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (ctx, index) => CollapsableTile(ordersList.elementAt(index)));
  }
}