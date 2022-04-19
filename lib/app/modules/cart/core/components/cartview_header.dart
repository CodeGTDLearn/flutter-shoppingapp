import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/components/core_alert_dialog.dart';
import '../../../../core/components/snackbar/core_snackbar.dart';
import '../../../../core/properties/properties.dart';
import '../../../../core/texts/core_labels.dart';
import '../../../../core/texts/core_messages.dart';
import '../../../inventory/controller/inventory_controller.dart';
import '../../controller/cart_controller.dart';
import '../../entity/cart_item.dart';
import '../cart_keys.dart';
import '../cart_labels.dart';

class CartViewHeader extends StatelessWidget {
  final _width;
  final _height;
  final CartController _cartController;
  final InventoryController _invController;
  final _messages = Get.find<CoreMessages>();
  final _words = Get.find<CoreLabels>();
  final _labels = Get.find<CartLabels>();
  final _keys = Get.find<CartKeys>();
  Map<String, CartItem> _availableItems = {};

  CartViewHeader(
    this._width,
    this._height,
    this._cartController,
    this._invController,
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
                      child: Text(_labels.cardCart, style: TextStyle(fontSize: 20))),
                  Container(
                      width: _width * 0.25,
                      child: Chip(
                          label: Obx(() {
                            var _total = _cartController.amountCartItemsObs.value;
                            return Text(
                                _total.isNegative ? " 00.00" : _total.toStringAsFixed(2),
                                style: TextStyle(color: Colors.white));
                          }),
                          backgroundColor: Theme.of(context).primaryColor)),
                  SizedBox(width: _width * 0.18),
                  Container(
                      color: Colors.blue,
                      width: _width * 0.3,
                      height: _height * 0.08,
                      child: _addOrderButton(enabled: true, context: context))
                ]))));
  }

  Widget _addOrderButton({required bool enabled, required BuildContext context}) {
    var _items = _cartController.getAllCartItems();
    _availableItems = _cartController.getAllAvailableCartItems(_items);

    if (_availableItems.isNotEmpty) _cartController.reloadQuantityAndAmountCart();

    return TextButton(
        key: Key(_keys.k_crt_ordnow_btn()),
        child: enabled
            ? Text(_labels.orderNowBtn, style: TextStyle(color: Colors.red))
            : Text(_labels.orderNowBtn, style: TextStyle(color: Colors.grey)),
        onPressed: enabled
            ? () => _availableItems.isNotEmpty
                ? _processingOrderAddittion(context)
                : Get.defaultDialog(content: Text(_labels.allItemUnavailable))
            : null);
  }

  void _processingOrderAddittion(BuildContext context) {
    // @formatter:off
    CoreAlertDialog.showOptionDialog(
    context,
    _words.confirm,
    _labels.dialogOrderNow,
    _words.yes,
    _labels.keepShop,
    () => {
      _cartController
          .addOrder(
            _availableItems.values.toList(),
            _cartController.amountCartItemsObs.value
          )
          .then((_) async  {
            _cartController.redrawListCart();
            await Future.delayed(Duration(milliseconds: 500));
            _cartController.clearCart();
            _invController.updateStockItemsQuantity(_availableItems);
            CoreSnackbar().show(_words.suces, _messages.suces_ord_add);
            await Future.delayed(Duration(milliseconds: DURATION + 400));
            Navigator.of(context).pop();
          })
          .catchError((error) {
             CoreSnackbar(5000).show('${_words.ops}$error', _messages.error_ord);
          })

    },
    () => {});
    // @formatter:on
  }
}