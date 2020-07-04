import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/titles_icons/views/orders.dart';
import 'components/order_collapse_tile.dart';
import 'orders_controller.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final OrdersController controller = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ORDERS_TIT_PAGE)),
      drawer: null,
      body: Container(
          child: ListView.builder(
              itemCount: controller.getAllOrders().length,
              itemBuilder: (ctx, item) =>
                  OrderCollapseTile(controller.getAllOrders()[item]))),
    );
  }
}
