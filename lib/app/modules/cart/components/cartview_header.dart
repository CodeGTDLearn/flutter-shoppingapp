import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_alert_dialog.dart';
import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/keys/cart_keys.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts/general_words.dart';
import '../../../core/texts/messages.dart';
import '../../../core/texts/modules/cart.dart';
import '../controller/cart_controller.dart';

class CartViewHeader extends StatelessWidget {
  final _width;
  final _height;
  final CartController _controller;

  CartViewHeader(
    this._width,
    this._height,
    this._controller,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shadowColor: Colors.black,
        margin: EdgeInsets.all(_width * 0.04),
        child: Padding(
            padding: EdgeInsets.all(_width * 0.02),
            child: Container(
                height: _height * 0.1,
                child: Row(children: [
                  Container(
                      width: _width * 0.15,
                      child: Text(CRT_LBL_CARD, style: TextStyle(fontSize: 20))),
                  Container(
                      width: _width * 0.25,
                      child: Obx(() => Chip(
                          label: Text(
                              _controller.amountCartItemsObs.value.toStringAsFixed(2),
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Theme.of(context).primaryColor))),
                  SizedBox(width: _width * 0.18),
                  Container(
                      width: _width * 0.3,
                      height: _height * 0.08,
                      child: Obx(() => (_controller.qtdeCartItemsObs().isEqual(0))
                          ? _controller.renderListView.value
                              ? CustomIndicator.radius(_width * 0.3)
                              : _addOrderButton(enabled: false)
                          : _addOrderButton(enabled: true)))
                ]))));
  }

  Builder _addOrderButton({required bool enabled}) {
    return Builder(builder: (_context) {
      return TextButton(
          key: Key(K_CRT_ORD_NOW_BTN),
          child: enabled
              ? Text(CRT_LBL_ORD,
                  style: TextStyle(color: Theme.of(_context).primaryColor))
              : Text(CRT_LBL_ORD,
                  style: TextStyle(color: Theme.of(_context).disabledColor)),
          onPressed: enabled
              ? () {
                  CustomAlertDialog.showOptionDialog(
                    _context,
                    CONFIRM,
                    CRT_MSG_CONF_ORDER,
                    YES,
                    CRT_LBL_KEEP,
                    // @formatter:off
                    () => {
                      _controller
                          .addOrder(_controller.getAllCartItems().values.toList(),
                              _controller.amountCartItemsObs.value)
                          .then((_) async {
                        _controller.renderListView.value = false;
                        await Future.delayed(Duration(milliseconds: 500));
                        _controller.clearCart.call();
                        SimpleSnackbar().show(SUCES, SUCES_ORD_ADD);
                        await Future.delayed(Duration(milliseconds: DURATION + 2000));
                        Get.back.call();
                      }).catchError((error) {
                        SimpleSnackbar(5000).show('$OPS$error', ERROR_ORD);
                      })
                    },
                    () => {Get.back()},
                    // @formatter:on
                  );
                }
              : null);
    });
  }
}