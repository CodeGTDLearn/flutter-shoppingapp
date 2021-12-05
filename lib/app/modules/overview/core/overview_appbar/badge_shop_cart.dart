import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/utils/animations_utils.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';

import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/cart_keys.dart';
import '../../../../core/properties/app_routes.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/overview/messages_snackbars_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../../cart/controller/cart_controller.dart';

class BadgeShopCart extends StatelessWidget {
  final Color? color;

  final _controller = Get.find<CartController>();
  final _animations = Get.find<AnimationsUtils>();

  BadgeShopCart({this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _animations.openContainer(
          milliseconds: 1000,
          openBuilder: CartView(),
          closedBuilder: Container(
              key: Key(K_SHP_CART_APPBAR_BTN),
              child: OV_ICO_SHOPCART,
              onPressed: () {
                if (_controller.getAllCartItems().isEmpty) {
                  SimpleSnackbar().show(OPS, CART_NO_ITEMS_YET);
                }
                if (_controller.getAllCartItems().isNotEmpty) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  Get.toNamed(AppRoutes.CART);
                }
              }),
        ),
        // IconButton(
        //     key: Key(K_SHP_CART_APPBAR_BTN),
        //     icon: OV_ICO_SHOPCART,
        //     onPressed: () {
        //       if (_controller.getAllCartItems().isEmpty) {
        //         SimpleSnackbar().show(OPS, CART_NO_ITEMS_YET);
        //       } else {
        //         ScaffoldMessenger.of(context).removeCurrentSnackBar();
        //         Get.toNamed(AppRoutes.CART);
        //         // Get.offNamed(AppRoutes.CART);
        //       }
        //     }),
        Positioned(
            right: 8,
            top: 8,
            child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color:
                        color != null ? color : Theme.of(context).colorScheme.secondary),
                constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                child: Obx(
                  () => Text(_controller.qtdeCartItemsObs.value.toString(),
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                )))
      ],
    );
  }
}