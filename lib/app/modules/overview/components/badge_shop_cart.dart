import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/snackbarr.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/core/cart_widget_keys.dart';
import '../core/messages_snackbars_provided.dart';
import '../core/overview_texts_icons_provided.dart';

class BadgeShopCart extends StatelessWidget {
  final Widget child;
  final int value;
  final Color color;

  final CartController _controller = Get.find<CartController>();

  BadgeShopCart({this.child, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      IconButton(
          key: Key(K_SHP_CART_APPBAR_BTN),
          icon: OV_ICO_SHOPCART,
          onPressed: () {
            // if (_controller.getAllCartItems().length == 0) {
            if (_controller.getAllCartItems().isEmpty) {
              SimpleSnackbar(OPS, NO_ITEMS_CART_YET).show();
            } else {
              // Scaffold.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
                () => Text(_controller.getQtdeCartItemsObs().toString(),
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
              )))
    ]);
  }
}
