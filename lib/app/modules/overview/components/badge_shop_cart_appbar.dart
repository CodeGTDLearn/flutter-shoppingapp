import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../config/app_properties.dart';
import '../../../config/app_routes.dart';
import '../../../config/messages/flush_notifier.dart';
import '../../../config/titles_icons/app_core.dart';
import '../../../config/titles_icons/views/overview.dart';
import '../../../modules/core/components/flush_notifier.dart';
import '../../cart/cart_controller.dart';

class BadgeShopCartAppbar extends StatelessWidget {
  final Widget child;
  final int value;
  final Color color;

  final CartController _controller = Get.put(CartController());

  BadgeShopCartAppbar({this.child, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      IconButton(
          icon: OVERVIEW_ICO_SHOP,
          onPressed: () {
            if (_controller.getAll().length == 0) {
              FlushNotifier(OPS, FLUSHNOTIF_MSG_CART_EMPTY, INTERVAL, context)
                  .simple();
            } else {
              Get.toNamed(CART_ROUTE);
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
            child: Text(_controller.qtdeCartItems.toString(),
                textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
          ))
    ]);
  }
}
