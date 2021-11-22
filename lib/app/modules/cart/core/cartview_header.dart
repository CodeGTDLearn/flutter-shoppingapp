import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/custom_widgets/custom_indicator.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';

import '../../../core/texts_icons_provider/pages/cart/cart_texts_icons_provided.dart';

class CartViewHeader extends StatelessWidget {
  final _lbWidth;
  final _lbHeight;
  final CartController _controller;
  final _addorderFunction;

  CartViewHeader(
    this._lbWidth,
    this._lbHeight,
    this._controller,
    this._addorderFunction,
  );

  // double lbWidth, double lbHeight, BuildContext context
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shadowColor: Colors.black,
        margin: EdgeInsets.all(_lbWidth * 0.04),
        child: Padding(
            padding: EdgeInsets.all(_lbWidth * 0.02),
            child: Container(
                height: _lbHeight * 0.1,
                child: Row(children: [
                  Container(
                      width: _lbWidth * 0.15,
                      child: Text(CRT_LBL_CARD, style: TextStyle(fontSize: 20))),
                  Container(
                      width: _lbWidth * 0.25,
                      child: Obx(() => Chip(
                          label: Text(
                              _controller.amountCartItemsObs.value.toStringAsFixed(2),
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Theme.of(context).primaryColor))),
                  SizedBox(width: _lbWidth * 0.18),
                  Container(
                      width: _lbWidth * 0.3,
                      height: _lbHeight * 0.08,
                      child: Obx(() => _controller.qtdeCartItemsObs().isEqual(0)
                          ? CustomIndicator.radius(_lbWidth * 0.3)
                          : _addorderFunction(_controller)))
                ]))));
  }
}