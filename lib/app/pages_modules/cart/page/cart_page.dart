import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../orders/core/messages_snackbars_provided.dart';
import '../../pages_generic_components/custom_snackbar.dart';
import '../components/card_cart_item.dart';
import '../controller/cart_controller.dart';
import '../core/cart_texts_icons_provided.dart';

class CartPage extends StatelessWidget {
  final CartController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    int currentQtdeCart = _controller.qtdeCartItems();
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
                    Expanded(
                      flex:2,
                      child: Container(
                          child: Text(CART_LBL_CARD,
                              style: TextStyle(fontSize: 20))),
                    ),
                    // Spacer(),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Chip(
                            label: Text(
                                _controller.amountCartItems.value
                                    .toStringAsFixed(2),
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Theme.of(context).primaryColor),
                      ),
                    ),
//testando no branch
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Obx(
                          () => _controller.qtdeCartItems() != currentQtdeCart
                              ? Center(child: CircularProgressIndicator())
                              : FlatButton(
                            // @formatter:off
                                 onPressed: () {
                                  _controller
                                      .addOrder(_controller.getAll().values.toList(),
                                          _controller.amountCartItems.value)
                                      .then((value) {
                                          Get.back();
                                          _controller.clearCart();
                                          _controller.recalcQtdeAndAmountCart();
                                          CustomSnackBar.simple(OPS, SUCESS_ORDER_ADD);
                                      }).catchError((onError) =>
                                          CustomSnackBar.simple(OPS, ERROR_ORDER));
                                  // Get.back();
                                },
                                // @formatter:on
                              child: Text(CART_LBL_ORDER,
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .primaryColor))),
                        ),
                      ),
                    ),

                  ]))),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: _controller
                      .getAll()
                      .length,
                  itemBuilder: (ctx, item) {
                    return CardCartItem(
                        _controller
                            .getAll()
                            .values
                            .elementAt(item));
                  }))
        ]));
  }
}
