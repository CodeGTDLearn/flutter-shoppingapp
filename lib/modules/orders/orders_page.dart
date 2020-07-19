import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/configurable/textual_interaction/titles_icons/views/orders.dart';
import 'components/order_collapse_tile.dart';
import 'order.dart';
import 'orders_controller.dart';

// ignore: must_be_immutable
class OrdersPage extends StatelessWidget {
  final OrdersController _controller = Get.find();

  List<Order> _orders;

  @override
  Widget build(BuildContext context) {
    _orders = _controller.getAllOrders();
    return Scaffold(
      appBar: AppBar(title: Text(ORDERS_TIT_PAGE)),
      drawer: null,
      body: Container(
          child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (ctx, item) => OrderCollapseTile(_orders[item]))),
    );
  }
}
