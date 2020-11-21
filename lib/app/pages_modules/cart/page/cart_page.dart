import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../orders/core/messages_snackbars_provided.dart';
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
    var fullSizeLessAppbar = MediaQuery.of(context).size;
    int currentQtdeCart = controller.qtdeCartItems();

    return Scaffold(
        appBar: AppBar(title: Text(CRT_TIT_APPBAR), actions: [
          IconButton(
              icon: CRT_ICO_CLEAR,
              onPressed: controller.clearCart,
              tooltip: CRT_ICO_CLEAR_TOOLT)
        ]),
        body: Container(
            width: fullSizeLessAppbar.width,
            height: fullSizeLessAppbar.height,
            child: LayoutBuilder(builder: (_, constraint) {
              var lbh = constraint.maxHeight;
              var lbw = constraint.maxWidth;
              return Column(children: [
                Card(
                    // color: Colors.red,
                    margin: EdgeInsets.all(lbw * 0.04),
                    child: Padding(
                        padding: EdgeInsets.all(lbw * 0.02),
                        child: Container(
                            height: lbh * 0.1,
                            child: Row(children: [
                              Container(
                                  width: lbw * 0.15,
                                  child: Text(CRT_LBL_CARD,
                                      style: TextStyle(fontSize: 20))),
                              Container(
                                  width: lbw * 0.25,
                                  child: Chip(
                                      label: Text(
                                          controller.amountCartItems.value
                                              .toStringAsFixed(2),
                                          style:
                                              TextStyle(color: Colors.white)),
                                      backgroundColor:
                                          Theme.of(context).primaryColor)),
                              SizedBox(width: lbw * 0.18),
                              Container(
                                  width: lbw * 0.3,
                                  height: lbh * 0.1,
                                  child: Obx(() => controller.qtdeCartItems() !=
                                          currentQtdeCart
                                      ? CustomCircProgresIndicator()
                                      : FlatButton(
                                          color: Colors.red,
                                      // @formatter:off
                                       onPressed: () {
                                        controller
                                        .addOrder(
                                            controller.getAllCartItems().values.toList(),
                                            controller.amountCartItems.value)
                                        .then((_) {
                                            Get.back();
                                            controller.clearCart();
                                            controller.recalcQtdeAndAmountCart();
                                            // CustomSnackbar2.simple(SUCES_ORD_ADD);
                                            CustomSnackbar.simple(
                                                message: SUCESS_ORDER_ADD,
                                                context: context);
                                        }).catchError((onError) =>
                                            // CustomSnackbar2.simple(ERROR_ORD));
                                        CustomSnackbar.simple(
                                            message: ERROR_ORDER,
                                            context: context));
                                       },
                                      // @formatter:on
                                      child: Text(CRT_LBL_ORDER,
                                          style: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor)))
                                  )
                              )
                            ])
                        ))),
                SizedBox(height: lbh * 0.01),
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
              ]);
            })
        ));
  }
}
