import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../../core/texts_icons_provider/pages/order/orders_texts_icons_provided.dart';
import '../controller/orders_controller.dart';
import '../core/custom_listview/orders_staggered_listview.dart';

// ignore: must_be_immutable
class OrdersView extends StatelessWidget {
  final _controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    _controller.getOrders();
    return Scaffold(
        appBar: AppBar(title: Text(ORD_TIT_PAGE)),
        body: Obx(() => _controller.ordersObs.isEmpty
            ? CustomIndicator.message(message: NO_ORD, fontSize: 20)
            : Container(
                child: OrdersStaggeredListview().create(_controller.ordersObs.toList()),
              )));
  }
}