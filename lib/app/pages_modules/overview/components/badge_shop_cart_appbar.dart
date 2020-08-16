import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_properties.dart';
import '../../../core/properties/app_routes.dart';
import '../../../texts_icons_provider/app_generic_words.dart';
import '../../cart/controller/cart_controller.dart';
import '../../pages_generic_components/custom_flush_notifier.dart';
import '../core/messages_provided/message_flush_notifier_provided.dart';
import '../core/overview_texts_icons_provided.dart';


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
          icon: OVERV_ICO_SHOP,
          onPressed: () {
            if (_controller.getAll().length == 0) {
              FlushNotifier(OPS, NO_ITEMS_CART, INTERVAL, context)
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
