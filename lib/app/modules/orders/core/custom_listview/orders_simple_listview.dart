import 'package:flutter/material.dart';

import '../../../../modules/orders/entity/order.dart';
import '../custom_collapsable_tile/order_collapsable_tile.dart';
import 'icustom_orders_listview.dart';

class OrdersSimpleListview implements ICustomOrdersListview {
  @override
  Widget create(List<Order> ordersList) {
    return ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (ctx, index) => OrderCollapsableTile(ordersList.elementAt(index)));
  }
}