import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/badge_cart.dart';
import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/custom_widgets/custom_sliver_appbar.dart';
import '../../../core/texts/messages.dart';
import '../../../core/texts/modules/orders.dart';
import '../components/custom_listview/staggered_sliver_listview.dart';
import '../controller/orders_controller.dart';

class OrdersView extends StatelessWidget {
  final _controller = Get.find<OrdersController>();
  final _sliverAppbar = Get.find<CustomSliverAppBar>();
  final _cartBadge = Get.find<BadgeCart>();

  @override
  Widget build(BuildContext context) {
    _controller.getOrders();
    return Scaffold(
        body: Obx(
      () => _controller.ordersObs.isEmpty
          ? CustomIndicator.message(message: NO_ORD, fontSize: 20)
          : CustomScrollView(slivers: [
              _sliverAppbar.create(ORD_TIT_PAGE, Get.back,actions: [_cartBadge]),
              StaggeredSliverListview().ordersListview(_controller.ordersObs.toList())
            ]),
    ));
  }
}