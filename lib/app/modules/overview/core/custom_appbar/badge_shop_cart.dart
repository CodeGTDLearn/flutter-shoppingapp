import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/cart_keys.dart';
import '../../../../core/properties/app_routes.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/overview/messages_snackbars_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../../cart/controller/cart_controller.dart';

class BadgeShopCart extends StatelessWidget {
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
            // todo: refactoring to ternary
            // cond ?
            // (() => {
            //   print("111ScaffoldMessenger.of(context).removeCurrentSnackBar()"),
            //   print("111Get.toNamed(AppRoutes.CART);")
            // }).call()
            //     : (() => {
            //   print("222ScaffoldMessenger.of(context).removeCurrentSnackBar()"),
            //   print("222Get.toNamed(AppRoutes.CART);")
            // })
            //     .call();
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