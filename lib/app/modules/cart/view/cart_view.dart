import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/progres_indicator.dart';
import '../../../core/components/snackbarr.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../orders/core/messages_snackbars_provided.dart';
import '../components/dismis_cart_item.dart';
import '../controller/cart_controller.dart';
import '../core/cart_texts_icons_provided.dart';
import '../core/cart_widget_keys.dart';

class CartView extends StatelessWidget {
  final CartController controller;

  CartView({required this.controller});

  Widget build(BuildContext context) {
    var fullSizeLessAppbar = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(CRT_TIT_APPBAR),
          actions: [_clearCartIconButton(controller)],
        ),
        body: Container(
            width: fullSizeLessAppbar.width,
            height: fullSizeLessAppbar.height,
            child: LayoutBuilder(builder: (_, constraint) {
              var lbHeight = constraint.maxHeight;
              var lbWidth = constraint.maxWidth;
              return Column(children: [
                Card(
                    margin: EdgeInsets.all(lbWidth * 0.04),
                    child: Padding(
                        padding: EdgeInsets.all(lbWidth * 0.02),
                        child: Container(
                            height: lbHeight * 0.1,
                            child: Row(children: [
                              Container(
                                  width: lbWidth * 0.15,
                                  child:
                                      Text(CRT_LBL_CARD, style: TextStyle(fontSize: 20))),
                              Container(
                                  width: lbWidth * 0.25,
                                  child: Obx(() => Chip(
                                      label: Text(
                                          controller.amountCartItemsObs.value
                                              .toStringAsFixed(2),
                                          style: TextStyle(color: Colors.white)),
                                      backgroundColor: Theme.of(context).primaryColor))),
                              SizedBox(width: lbWidth * 0.18),
                              Container(
                                  width: lbWidth * 0.3,
                                  height: lbHeight * 0.08,
                                  child: Obx(() =>
                                      controller.qtdeCartItemsObs().isEqual(0)
                                          ? ProgresIndicator.radius(lbWidth * 0.3)
                                          : _addOrderButton(controller)))
                            ])))),
                SizedBox(height: lbHeight * 0.01),
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.getAllCartItems().length,
                      itemBuilder: (ctx, item) {
                        return DismisCartItem.DimissCartItem(
                            controller.getAllCartItems().values.elementAt(item));
                      }),
                )
              ]);
            })));
  }

  IconButton _clearCartIconButton(CartController controller) {
    return IconButton(
        key: Key(K_CRT_CLR_CART_BTN),
        icon: CRT_ICO_CLEAR,
        onPressed: () {
          controller.clearCart.call();
          SimpleSnackbar(SUCES, SUCES_ORD_CLEAN).show();
          Future.delayed(Duration(milliseconds: DURATION)).whenComplete(Get.back);
        },
        tooltip: CRT_ICO_CLEAR_TOOLT);
  }

  Builder _addOrderButton(CartController controller) {
    return Builder(builder: (_context) {
      // return FlatButton(
      return TextButton(
          key: Key(K_CRT_ORD_NOW_BTN),
          child:
              Text(CRT_LBL_ORD, style: TextStyle(color: Theme.of(_context).primaryColor)),
          onPressed: () {
            controller
                .addOrder(
                  controller.getAllCartItems().values.toList(),
                  controller.amountCartItemsObs.value,
                )
                .then((_) {
                  controller.clearCart();
                  SimpleSnackbar(SUCES, SUCES_ORD_ADD).show();
                })
                .whenComplete(() => Future.delayed(Duration(milliseconds: DURATION))
                    .then((value) => Get.back()))
                .catchError((error) {
                  SimpleSnackbar('$OPS$error', ERROR_ORD, 5000).show();
                });
          });
    });
  }
}
