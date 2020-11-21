import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../orders/core/messages_snackbars_provided.dart';
import '../../pages_generic_components/app_messages_provided.dart';
import '../../pages_generic_components/custom_circ_progres_indicator.dart';
import '../../pages_generic_components/custom_snackbar.dart';
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
        appBar: AppBar(title: Text(CRT_TIT_APPBAR), actions: <Widget>[
          IconButton(
              icon: CRT_ICO_CLEAR,
              onPressed: controller.clearCart,
              tooltip: CRT_ICO_CLEAR_TOOLT)
        ]),
        //todo: delete the expandeds and change for layoutbuilder
        body: Column(children: [
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                          child: Text(CRT_LBL_CARD,
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
                              ? CustomCircProgresIndicator(message: NO_CRTITEM)
                              : FlatButton(
                            // @formatter:off
                                 onPressed: () {
                                  controller
                                      .addOrder(controller.getAllCartItems().values.toList(),
                                          controller.amountCartItems.value)
                                      .then((value) {
                                          Get.back();
                                          controller.clearCart();
                                          controller.recalcQtdeAndAmountCart();
                                          CustomSnackbar.simple(
                                              message: SUCESS_ORDER_ADD,
                                              context: context);
                                      }).catchError((onError) =>
                                       CustomSnackbar.simple(
                                      message: ERROR_ORDER,
                                      context: context));

                                  // Get.back();
                                },
                                // @formatter:on
                              child: Text(CRT_LBL_ORDER,
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
                      .getAllCartItems()
                      .length,
                  itemBuilder: (ctx, item) {
                    return CardCartItem(
                        controller
                            .getAllCartItems()
                            .values
                            .elementAt(item));
                  }))
        ]));
  }
}
