import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_properties.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../cart/controller/cart_controller.dart';
import '../../pages_generic_components/custom_flushbar.dart';
import '../core/messages_snackbars_provided.dart';
import '../core/overview_texts_icons_provided.dart';
import '../core/overview_widget_keys.dart';

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
          icon: OV_ICO_SHOP,
          onPressed: () {
            if (_controller.getAll().length == 0) {
              CustomFlushbar(OPS, NO_ITEMS_CART_YET, context, INTERVAL)
                  .simple();
            } else {
              Get.toNamed(AppRoutes.CART);
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
                  key: Key(OV004),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10)),
            ),
          ))
    ]);
  }
}
