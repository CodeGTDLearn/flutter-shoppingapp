import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/order_collapse_tile.dart';
import '../controller/orders_controller.dart';
import '../core/orders_texts_icons_provided.dart';
import '../entities/order.dart';

// ignore: must_be_immutable
class OrdersPage extends StatelessWidget {
  final OrdersController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.getOrders();
    return Scaffold(
      appBar: AppBar(title: Text(ORD_TIT_PAGE)),
      body: Obx(() => _controller.ordersObs.length == 0
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                  itemCount: _controller.ordersObs.length,
                  itemBuilder: (ctx, item) =>
                      OrderCollapseTile(_controller.ordersObs.value[item])))),
    );
  }
}
