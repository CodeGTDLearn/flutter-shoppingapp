import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../orders/core/messages_snackbars_provided.dart';
import '../../pages_generic_components/custom_flushbar.dart';
import '../components/card_cart_item.dart';
import '../controller/cart_controller.dart';
import '../core/cart_texts_icons_provided.dart';

class CartPage extends StatelessWidget {
  final CartController controller;

  CartPage({this.controller});

  @override
  Widget build(BuildContext context) {
    int currentQtdeCart = controller.qtdeCartItems();
    return Scaffold(
        appBar: AppBar(title: Text(CART_TIT_APPBAR), actions: <Widget>[
          IconButton(
              icon: CART_ICO_CLEAR,
              onPressed: controller.clearCart,
              tooltip: CART_ICO_CLEAR_TOOLTIP)
        ]),
        body: Column(children: [
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      flex: 2,
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
                                controller.amountCartItems.value
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
                          () => controller.qtdeCartItems() != currentQtdeCart
                              ? Center(child: CircularProgressIndicator())
                              : FlatButton(
                            // @formatter:off
                                 onPressed: () {
                                  controller
                                      .addOrder(controller.getAll().values.toList(),
                                          controller.amountCartItems.value)
                                      .then((value) {
                                          Get.back();
                                          controller.clearCart();
                                          controller.recalcQtdeAndAmountCart();
                                          // CustomSnackbar.simple(OPS, SUCESS_ORDER_ADD);
                                          CustomFlushbar(
                                              OPS,
                                              SUCESS_ORDER_ADD,
                                            context
                                          ).simple();
                                      }).catchError((onError) =>
                                          // CustomSnackbar.simple(OPS, ERROR_ORDER));
                                  CustomFlushbar(
                                      OPS,
                                      ERROR_ORDER,
                                      context
                                  ).simple());

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
                  itemCount: controller
                      .getAll()
                      .length,
                  itemBuilder: (ctx, item) {
                    return CardCartItem(
                        controller
                            .getAll()
                            .values
                            .elementAt(item));
                  }))
        ]));
  }
}
