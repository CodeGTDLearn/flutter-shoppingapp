import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_routes.dart';
import '../../../core/components/flush_notifier.dart';
import '../../../core/configurable/app_properties.dart';
import '../../../core/configurable/textual_interaction/messages/flush_notifier.dart';
import '../../../core/configurable/textual_interaction/titles_icons/app_core.dart';
import '../../../core/configurable/textual_interaction/titles_icons/views/overview.dart';
import '../../cart/controller/cart_controller.dart';


class BadgeShopCartAppbar extends StatelessWidget {
  final Widget child;
  final int value;
  final Color color;

  final CartController _controller = Get.find();

  BadgeShopCartAppbar({this.child, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      IconButton(
          icon: OVERVIEW_ICO_SHOP,
          onPressed: () {
            if (_controller.getAll().length == 0) {
              FlushNotifier(OPS, MSG_NO_ITEMS_IN_CART, INTERVAL, context)
                  .simple();
            } else {
              Get.toNamed(AppRoutes.CART_ROUTE);
            }
          }),
      Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: color != null ? color : Theme.of(context).accentColor),
            constraints: BoxConstraints(minWidth: 16, minHeight: 16),
            child: Obx(
              () => Text(_controller.qtdeCartItems.value.toString(),
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
            ),
          ))
    ]);
  }
}
