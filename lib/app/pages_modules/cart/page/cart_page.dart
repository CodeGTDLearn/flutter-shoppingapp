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
              var constHeight = constraint.maxHeight;
              var constWidth = constraint.maxWidth;
              return Column(children: [
                Card(
                    margin: EdgeInsets.all(constWidth * 0.04),
                    child: Padding(
                        padding: EdgeInsets.all(constWidth * 0.02),
                        child: Container(
                            height: constHeight * 0.1,
                            child: Row(children: [
                              Container(
                                  width: constWidth * 0.15,
                                  child: Text(CRT_LBL_CARD,
                                      style: TextStyle(fontSize: 20))),
                              Container(
                                  width: constWidth * 0.25,
                                  child: Chip(
                                      label: Text(
                                          controller.amountCartItems.value
                                              .toStringAsFixed(2),
                                          style:
                                              TextStyle(color: Colors.white)),
                                      backgroundColor:
                                          Theme.of(context).primaryColor)),
                              SizedBox(width: constWidth * 0.18),
                              Container(
                                  // width: constWidth * 0.3,
                                  // height: constHeight * 0.08,
                                  child: Obx(() => controller.qtdeCartItems() !=
                                          currentQtdeCart
                                      ? CustomCircularProgressIndicator.radius(
                                          constHeight * 0.1)
                                      : _addOrderButton()))
                            ])))),
                SizedBox(height: constHeight * 0.01),
                Expanded(
                    child: ListView.builder(
                        itemCount: controller.getAllCartItems().length,
                        itemBuilder: (ctx, item) {
                          return CardCartItem(controller
                              .getAllCartItems()
                              .values
                              .elementAt(item));
                        }))
              ]);
            })));
  }

  Builder _addOrderButton() {
    return Builder(builder: (builderContext) {
      return FlatButton(
          child: Text(CRT_LBL_ORDER,
              style: TextStyle(color: Theme.of(builderContext).primaryColor)),
          onPressed: () {
            controller
                .addOrder(controller.getAllCartItems().values.toList(),
                    controller.amountCartItems.value)
                .then((_) {
              CustomSnackbar.simple(
                  message: SUCESS_ORDER_ADD, context: builderContext);
              controller.clearCart();
              controller.recalcQtdeAndAmountCart();
            })
                // .whenComplete(() => Future.delayed(Duration(seconds: 1))
                //     .then((value) => Get.back()))
                .catchError((onError) => CustomSnackbar.simple(
                    message: ERROR_ORDER, context: builderContext));
          });
    });
  }
}
