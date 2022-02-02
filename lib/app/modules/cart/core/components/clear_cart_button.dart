import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../../core/components/custom_alert_dialog.dart';
import '../../../../core/components/snackbar/simple_snackbar.dart';
import '../../../../core/properties/properties.dart';
import '../../../../core/texts/global_labels.dart';
import '../../../../core/texts/global_messages.dart';
import '../../controller/cart_controller.dart';
import '../cart_icons.dart';
import '../cart_keys.dart';
import '../cart_labels.dart';

class ClearCartButton extends StatelessWidget {
  final CartController _controller;
  final _icons = Get.find<CartIcons>();
  final _messages = Get.find<GlobalMessages>();
  final _words = Get.find<GlobalLabels>();
  final _labels = Get.find<CartLabels>();
  final _keys = Get.find<CartKeys>();

  ClearCartButton(this._controller);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: Key(_keys.k_crt_clearcart_btn()),
        icon: _icons.ico_clear(),
        onPressed: () => CustomAlertDialog.showOptionDialog(
              context,
              _words.attent,
              _labels.label_dialog_clearall,
              _words.yes,
              _words.no,
              () async {
                _controller.renderListView.value = false;
                await Future.delayed(Duration(milliseconds: 500));
                _controller.clearCart.call();
                SimpleSnackbar().show(_words.suces, _messages.suces_ord_clean);
                await Future.delayed(Duration(milliseconds: DURATION + 2000));
                Get.back.call();
              },
              () async {},
            ),
        tooltip: _labels.label_tootip_clear_cart);
  }
}