import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../modules/cart/controller/cart_controller.dart';
import '../icons/overview.dart';
import '../keys/cart_keys.dart';
import '../properties/app_routes.dart';
import '../texts/general_words.dart';
import '../texts/messages.dart';
import 'custom_snackbar/simple_snackbar.dart';

class BadgeCart extends StatelessWidget {
  final Color? color;

  final _controller = Get.find<CartController>();

  BadgeCart({this.color});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          SlideTransition(
            position: _controller.badgeShopCartAnimation as Animation<Offset>,
            child: IconButton(
                key: Key(K_SHP_CART_APPBAR_BTN),
                icon: OV_ICO_SHOPCART,
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
                child: Text(_controller.qtdeCartItemsObs.value.toString(),
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
              ))
        ],
      ),
    );
  }
}