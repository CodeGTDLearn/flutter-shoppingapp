import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/custom_widgets/custom_alert_dialog.dart';

import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/texts_icons_provider/pages/cart/cart_texts_icons_provided.dart';
import '../controller/cart_controller.dart';

class CartViewHeader extends StatelessWidget {
  final _width;
  final _height;
  final CartController _controller;
  final _addOrderFunction;

  CartViewHeader(this._width,
      this._height,
      this._controller,
      this._addOrderFunction,);

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
                      child: Obx(() =>
                          Chip(
                              label: Text(
                                  _controller.amountCartItemsObs.value.toStringAsFixed(2),
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor))),
                  SizedBox(width: _width * 0.18),
                  Container(
                      width: _width * 0.3,
                      height: _height * 0.08,
                      child: Obx(
                              () =>
                          _controller.qtdeCartItemsObs().isEqual(0)
                              ? CustomIndicator.radius(_width * 0.3)
                          // : _addOrderFunction(_controller),
                              : CustomAlertDialog.showOptionDialog(
                            context,
                            CRT_LBL_CONF_DISM,
                            '$CRT_MSG_CONF_DISM${_cartItem.title} from the cart?',
                            YES,
                            NO,
                                () => {_addOrderFunction(_controller).call()},
                                () => {},
                          );
                      ))
                ]))));
  }
}