import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/components/appbar/core_appbar.dart';
import '../../../core/components/appbar/core_sliver_appbar.dart';
import '../../../core/components/badge/core_badge_cart.dart';
import '../../../core/components/core_adaptive_indicator.dart';
import '../../../core/texts/core_messages.dart';
import '../../orders/core/components/custom_listview/staggered_sliver_listview.dart';
import '../controller/orders_controller.dart';
import '../core/orders_labels.dart';

class OrdersView extends StatelessWidget {
  final _controller = Get.find<OrdersController>();
  final _appbar = Get.find<CoreAppBar>();
  final _sliverAppbar = Get.find<CoreSliverAppBar>();
  final _cartBadge = Get.find<CoreBadgeCart>();
  final _messages = Get.find<CoreMessages>();
  final _labels = Get.find<OrdersLabels>();

  @override
  Widget build(BuildContext context) {
    _controller.getOrders();
    return Obx(() => Scaffold(
          appBar: _controller.ordersObs.isEmpty
              ? _appbar.create(_labels.titlePage, Get.back)
              : null,
          body:
              // Obx(
              //   () =>
              _controller.ordersObs.isEmpty
                  ? CoreAdaptiveIndicator.message(
                      message: _messages.no_orders_yet, fontSize: 20)
                  : CustomScrollView(slivers: [
                      _sliverAppbar
                          .create(_labels.titlePage, Get.back, actions: [_cartBadge]),
                      StaggeredSliverListview()
                          .ordersListview(_controller.ordersObs.toList())
                    ]),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}