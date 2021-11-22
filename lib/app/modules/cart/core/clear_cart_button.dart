import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:shopingapp/app/core/properties/app_properties.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';

import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/keys/cart_keys.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/cart/cart_texts_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/order/messages_snackbars_provided.dart';

class ClearCartButton extends StatelessWidget {
  final CartController _controller;

  ClearCartButton(this._controller);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: Key(K_CRT_CLR_CART_BTN),
        icon: CRT_ICO_CLEAR,
        onPressed: () {
          _controller.renderStaggeredListView.value =
              !_controller.renderStaggeredListView.value;
          // _controller.clearCart.call();
          // _controller.deleteObs.value = !_controller.deleteObs.value;
          SimpleSnackbar(SUCES, SUCES_ORD_CLEAN).show();
          Future.delayed(Duration(milliseconds: DURATION + 2000)).whenComplete(Get.back);
        },
        tooltip: CRT_ICO_CLEAR_TOOLT);
  }
}