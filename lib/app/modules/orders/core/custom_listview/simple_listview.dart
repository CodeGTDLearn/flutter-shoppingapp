import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../../modules/orders/entity/order.dart';
import '../custom_tiles/icustom_order_tile.dart';
import 'icustom_orders_listview.dart';

class SimpleListview implements ICustomOrdersListview {
  final _orderTile = Get.find<ICustomOrderTile>();

  @override
  Widget ordersListview(List<Order> ordersList) {
    return ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (ctx, index) => _orderTile.create(ordersList.elementAt(index)));
  }
}