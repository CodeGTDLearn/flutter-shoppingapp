import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../config/app_monitor_builds.dart';
import '../../config/titles_icons/views/orders.dart';
import 'components/order_collapsable_tile.dart';
import 'orders_controller.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends ModularState<OrdersPage, OrdersController> {
  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_VIEW_ORDERS);
    return Scaffold(
      appBar: AppBar(title: Text(ORDERS_TIT_PAGE)),
      drawer: null,
      body: Container(
          child: ListView.builder(
              itemCount: controller.getAll().length,
              itemBuilder: (ctx, item) =>
                  OrderCollapsableTile(controller.getAll()[item]))),
    );
  }
}
