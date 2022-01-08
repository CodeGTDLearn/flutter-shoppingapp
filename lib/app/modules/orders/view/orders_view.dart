import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/global_widgets/appbar/custom_sliver_appbar.dart';
import '../../../core/global_widgets/badge_cart.dart';
import '../../../core/global_widgets/custom_indicator.dart';
import '../../../core/labels/message_labels.dart';
import '../../../core/labels/modules/orders_labels.dart';
import '../components/custom_listview/staggered_sliver_listview.dart';
import '../controller/orders_controller.dart';

class OrdersView extends StatelessWidget {
  final _controller = Get.find<OrdersController>();
  final _sliverAppbar = Get.find<CustomSliverAppBar>();
  final _cartBadge = Get.find<BadgeCart>();
  final _messages = Get.find<MessageLabels>();
  final _labels = Get.find<OrdersLabels>();

  @override
  Widget build(BuildContext context) {
    _controller.getOrders();
    return Scaffold(
        body: Obx(
      () => _controller.ordersObs.isEmpty
          ? CustomIndicator.message(message: _messages.no_orders_yet(), fontSize: 20)
          : CustomScrollView(slivers: [
              _sliverAppbar.create(_labels.label_title_page(), Get.back,actions: [_cartBadge]),
              StaggeredSliverListview().ordersListview(_controller.ordersObs.toList())
            ]),
    ));
  }
}