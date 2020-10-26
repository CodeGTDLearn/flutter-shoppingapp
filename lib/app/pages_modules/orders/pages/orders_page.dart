import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/order_collapse_tile.dart';
import '../controller/orders_controller.dart';
import '../core/orders_texts_icons_provided.dart';

// ignore: must_be_immutable
class OrdersPage extends StatelessWidget {
  final OrdersController controller;

  OrdersPage({this.controller});

  @override
  Widget build(BuildContext context) {
    controller.getOrders();
    return Scaffold(
      appBar: AppBar(title: Text(ORD_TIT_PAGE)),
      body: Obx(() => controller.ordersObs.length == 0
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                  itemCount: controller.ordersObs.length,
                  itemBuilder: (ctx, item) =>
                      OrderCollapseTile(controller.ordersObs.value[item])))),
    );
  }
}
