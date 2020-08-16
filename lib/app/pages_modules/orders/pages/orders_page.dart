import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/order_collapse_tile.dart';
import '../controller/orders_controller.dart';
import '../core/orders_texts_icons_provided.dart';
import '../entities/order.dart';

// ignore: must_be_immutable
class OrdersPage extends StatelessWidget {
  final OrdersController _controller = Get.find();

  List<Order> _orders;

  @override
  Widget build(BuildContext context) {
    _orders = _controller.getAllOrders();
    return Scaffold(
      appBar: AppBar(title: Text(ORD_TIT_PAGE)),
      drawer: null,
      body: Container(
          child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (ctx, item) => OrderCollapseTile(_orders[item]))),
    );
  }
}
