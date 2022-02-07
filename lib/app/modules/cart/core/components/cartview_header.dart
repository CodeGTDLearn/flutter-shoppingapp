import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/components/core_adaptive_indicator.dart';
import '../../../../core/components/core_alert_dialog.dart';
import '../../../../core/components/snackbar/core_snackbar.dart';
import '../../../../core/properties/properties.dart';
import '../../../../core/texts/core_labels.dart';
import '../../../../core/texts/core_messages.dart';
import '../../controller/cart_controller.dart';
import '../cart_keys.dart';
import '../cart_labels.dart';

class CartViewHeader extends StatelessWidget {
  final _width;
  final _height;
  final CartController _controller;
  final _messages = Get.find<CoreMessages>();
  final _words = Get.find<CoreLabels>();
  final _labels = Get.find<CartLabels>();
  final _keys = Get.find<CartKeys>();

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
                      child:
                          Text(_labels.label_card_cart, style: TextStyle(fontSize: 20))),
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
                      child: Obx(() => (_controller.qtdeCartItemsObs.value == 0)
                          ? _controller.renderListView.value
                              ? CoreAdaptiveIndicator.radius(_width * 0.3)
                              : _addOrderButton(enabled: false)
                          : _addOrderButton(enabled: true)))
                ]))));
  }

  Builder _addOrderButton({required bool enabled}) {
    return Builder(builder: (_context) {
      return TextButton(
          key: Key(_keys.k_crt_ordnow_btn()),
          child: enabled
              ? Text(_labels.label_ordernow_btn,
                  style: TextStyle(color: Theme.of(_context).primaryColor))
              : Text(_labels.label_ordernow_btn,
                  style: TextStyle(color: Theme.of(_context).disabledColor)),
          onPressed: enabled
              ? () {
                  CoreAlertDialog.showOptionDialog(
                    _context,
                    _words.confirm(),
                    _labels.label_dialog_ordernow,
                    _words.yes(),
                    _labels.label_keep_shop,
              // @formatter:off
                    () => {
                      _controller
                          .addOrder(_controller.getAllCartItems().values.toList(),
                              _controller.amountCartItemsObs.value)
                          .then((_) async {
                        _controller.renderListView.value = false;
                        await Future.delayed(Duration(milliseconds: 500));
                        _controller.clearCart.call();
                        CoreSnackbar().show(_words.suces, _messages.suces_ord_add);
                        await Future.delayed(Duration(milliseconds: DURATION + 2000));
                        Get.back.call();
                      }).catchError((error) {
                        CoreSnackbar(5000).show('${_words.ops()}$error', _messages
                            .error_ord());
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