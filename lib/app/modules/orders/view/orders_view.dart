import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_appbar.dart';
import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../../core/texts_icons_provider/pages/order/orders_texts_icons_provided.dart';
import '../controller/orders_controller.dart';
import '../core/custom_listview/orders_staggered_listview.dart';

class OrdersView extends StatelessWidget {
  final _controller = Get.find<OrdersController>();
  final _appbar = Get.find<CustomAppBar>();

  @override
  Widget build(BuildContext context) {
    _controller.getOrders();
    return Scaffold(
        appBar: _appbar.create(
          ORD_TIT_PAGE,
          () => Get.offNamed(AppRoutes.OVERVIEW_ALL),
        ),
        body: Obx(() => _controller.ordersObs.isEmpty
            ? CustomIndicator.message(message: NO_ORD, fontSize: 20)
            : Container(
                child: OrdersStaggeredListview().create(_controller.ordersObs.toList()),
              )));
  }
}