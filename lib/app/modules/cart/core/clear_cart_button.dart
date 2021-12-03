import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

import '../../../core/custom_widgets/custom_alert_dialog.dart';
import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/keys/cart_keys.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/cart/cart_texts_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/order/messages_snackbars_provided.dart';
import '../controller/cart_controller.dart';

class ClearCartButton extends StatelessWidget {
  final CartController _controller;

  ClearCartButton(this._controller);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: Key(K_CRT_CLR_CART_BTN),
        icon: CRT_ICO_CLEAR,
        onPressed: () => CustomAlertDialog.showOptionDialog(
              context,
              ATTENT,
              CRT_MSG_CONF_CLEAR_ALL,
              YES,
              NO,
              () async {
                _controller.renderListView.value = false;
                await Future.delayed(Duration(milliseconds: 500));
                _controller.clearCart.call();
                SimpleSnackbar().show(SUCES, SUCES_ORD_CLEAN);
                await Future.delayed(Duration(milliseconds: DURATION + 2000));
                Get.back.call();
              },
              () async {},
            ),
        tooltip: CRT_ICO_CLEAR_TOOLT);
  }
}