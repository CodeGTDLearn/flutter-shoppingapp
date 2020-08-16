import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/card_cart_item.dart';
import '../controller/cart_controller.dart';
import '../core/cart_texts_icons_provided.dart';

class CartPage extends StatelessWidget {
  final CartController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(CART_TIT_APPBAR), actions: <Widget>[
          IconButton(
              icon: CART_ICO_CLEAR,
              onPressed: _controller.clearCart,
              tooltip: CART_ICO_CLEAR_TOOLTIP)
        ]),
        body: Column(children: [
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Text(CART_LBL_CARD, style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Chip(
                        label: Text(
                            _controller.amountCartItems.value
                                .toStringAsFixed(2),
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Theme.of(context).primaryColor),
                    FlatButton(
                        onPressed: () {
                          _controller.addOrder(
                            _controller.getAll().values.toList(),
                            _controller.amountCartItems.value,
                          );
                          _controller.clearCart();
                          _controller.recalcQtdeAndAmountCart();
                          Get.back();
                        },
                        child: Text(CART_LBL_ORDER,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)))
                  ]))),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: _controller.getAll().length,
                  itemBuilder: (ctx, item) {
                    return CardCartItem(
                        _controller.getAll().values.elementAt(item));
                  }))
        ]));
  }
}
