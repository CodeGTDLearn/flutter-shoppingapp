import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/cart/controller/cart_controller.dart';
import '../../../modules/cart/core/cart_widget_keys.dart';
import '../../../modules/overview/core/messages_snackbars_provided.dart';
import '../../../modules/overview/core/overview_texts_icons_provided.dart';
import '../../properties/app_routes.dart';
import '../../texts_icons_provider/generic_words.dart';
import '../custom_snackbar/simple_snackbar.dart';

class BadgeShopCart extends StatelessWidget {
  // final Widget? child;
  // final int? value;
  final Color? color;

  final CartController _controller = Get.find<CartController>();

  BadgeShopCart({this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      IconButton(
          key: Key(K_SHP_CART_APPBAR_BTN),
          icon: OV_ICO_SHOPCART,
          onPressed: () {
            if (_controller.getAllCartItems().isEmpty) {
              SimpleSnackbar(OPS, CART_NO_ITEMS_YET).show();
            } else {
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
                  color: color != null ? color : Theme.of(context).colorScheme.secondary),
              constraints: BoxConstraints(minWidth: 16, minHeight: 16),
              child: Obx(
                () => Text(_controller.getQtdeCartItemsObs().toString(),
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
              )))
    ]);
  }
}