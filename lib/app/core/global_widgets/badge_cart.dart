import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../modules/cart/controller/cart_controller.dart';
import '../icons/modules/overview_icons.dart';
import '../keys/modules/cart_keys.dart';
import '../labels/global_labels.dart';
import '../labels/message_labels.dart';
import '../properties/routes.dart';
import 'snackbar/simple_snackbar.dart';

class BadgeCart extends StatelessWidget {
  final Color? color;

  final _words = Get.find<GlobalLabels>();
  final _messages = Get.find<MessageLabels>();
  final _icons = Get.find<OverviewIcons>();
  final _controller = Get.find<CartController>();
  final _keys = Get.find<CartKeys>();

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
                key: Key(_keys.k_shopcart_appbar_btn()),
                icon: _icons.ico_shopcart(),
                onPressed: () {
                  if (_controller.getAllCartItems().isEmpty) {
                    SimpleSnackbar().show(_words.ops(), _messages.cart_no_items_yet());
                  }
                  if (_controller.getAllCartItems().isNotEmpty) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    Get.toNamed(Routes.CART);
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