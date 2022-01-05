import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../modules/cart/controller/cart_controller.dart';
import '../icons/modules/overview_icons.dart';
import '../keys/modules/cart_keys.dart';
import '../properties/app_routes.dart';
import '../texts/general_words.dart';
import '../texts/messages.dart';
import 'snackbar/simple_snackbar.dart';

class BadgeCart extends StatelessWidget {
  final Color? color;

  final _words = Get.find<GeneralWords>();
  final _messages = Get.find<Messages>();
  final _icons = Get.find<OverviewIcons>();
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
                icon: _icons.ico_shopcart(),
                onPressed: () {
                  if (_controller.getAllCartItems().isEmpty) {
                    SimpleSnackbar().show(_words.ops(), _messages.cart_no_items_yet());
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