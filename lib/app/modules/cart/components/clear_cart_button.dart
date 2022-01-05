import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../core/custom_widgets/custom_alert_dialog.dart';
import '../../../core/custom_widgets/snackbar/simple_snackbar.dart';
import '../../../core/icons/modules/cart_icons.dart';
import '../../../core/keys/modules/cart_keys.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts/general_words.dart';
import '../../../core/texts/messages.dart';
import '../../../core/texts/modules/cart_labels.dart';
import '../controller/cart_controller.dart';

class ClearCartButton extends StatelessWidget {
  final CartController _controller;
  final _icons = Get.find<CartIcons>();
  final _messages = Get.find<Messages>();
  final _words = Get.find<GeneralWords>();
  final _labels = Get.find<CartLabels>();

  ClearCartButton(this._controller);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: Key(K_CRT_CLR_CART_BTN),
        icon: _icons.ico_clear(),
        onPressed: () => CustomAlertDialog.showOptionDialog(
              context,
              _words.attent(),
              _labels.label_dialog_clearall(),
              _words.yes(),
              _words.no(),
              () async {
                _controller.renderListView.value = false;
                await Future.delayed(Duration(milliseconds: 500));
                _controller.clearCart.call();
                SimpleSnackbar().show(_words.suces(), _messages.suces_ord_clean());
                await Future.delayed(Duration(milliseconds: DURATION + 2000));
                Get.back.call();
              },
              () async {},
            ),
        tooltip: _labels.label_tootip_clear_cart());
  }
}