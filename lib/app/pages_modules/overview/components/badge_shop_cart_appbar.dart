import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_properties.dart';
import '../../../core/properties/app_routes.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/core/cart_widget_keys.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../core/messages_snackbars_provided.dart';
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
          key: Key(K_SHP_CART_APPBAR_BTN),
          icon: OV_ICO_SHOPCART,
          onPressed: () {
            if (_controller.getAllCartItems().length == 0) {
              // CustomSnackbar.simple(
              //     message: NO_ITEMS_CART_YET,
              //     context: context,
              //     duration: DURATION);
              SimpleSnackbar(NO_ITEMS_CART_YET, context, DURATION).show();
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
                () => Text(_controller.qtdeCartItemsObs.value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10)),
              )))
    ]);
  }
}
