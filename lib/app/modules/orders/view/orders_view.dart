import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/app_messages_provided.dart';
import '../../../core/components/progres_indicator.dart';
import '../components/order_collapsable_tile.dart';
import '../controller/orders_controller.dart';
import '../core/orders_texts_icons_provided.dart';

// ignore: must_be_immutable
class OrdersView extends StatelessWidget {
  final OrdersController controller;

  OrdersView({this.controller});

  @override
  Widget build(BuildContext context) {
    controller.getOrders();
    return Scaffold(
        appBar: AppBar(title: Text(ORD_TIT_PAGE)),
        body: Obx(() => controller.ordersObs.length == 0
            ? ProgresIndicator.message(message: NO_ORD, fontSize: 20)
            : Container(
                child: ListView.builder(
                    itemCount: controller.ordersObs.length,
                    itemBuilder: (ctx, item) => OrderCollapsableTile(
                        controller.ordersObs.toList()[item])))));
  }
}
