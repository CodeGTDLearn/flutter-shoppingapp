import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/keys/cart_keys.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/cart/cart_texts_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/order/messages_snackbars_provided.dart';
import '../controller/cart_controller.dart';
import '../core/cartview_header.dart';
import '../core/clear_cart_button.dart';
import '../core/custom_listview/cart_staggered_listview.dart';

class CartView extends StatelessWidget {
  final _controller = Get.find<CartController>();

  Widget build(BuildContext context) {
    var fullSizeLessAppbar = MediaQuery.of(context).size;
    _controller.renderListView.value = true;
    return Scaffold(
        appBar:
            AppBar(title: Text(CRT_TIT_APPBAR), actions: [ClearCartButton(_controller)]),
        body: Container(
            width: fullSizeLessAppbar.width,
            height: fullSizeLessAppbar.height,
            child: LayoutBuilder(builder: (_, constraint) {
              var _height = constraint.maxHeight;
              var _width = constraint.maxWidth;
              return Column(children: [
                CartViewHeader(_width, _height, _controller, _addOrderButton),
                SizedBox(height: _height * 0.01),
                Expanded(
                    child: Obx(() => _controller.renderListView.value
                        ? Container(
                            child: CartStaggeredListview(
                              fadeEffect: true,
                              invertTargetPosition: false,
                              verticalOffset: (_height * 0.625),
                            ).create(_controller.getAllCartItems()),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              CartStaggeredListview(
                                fadeEffect: false,
                                invertTargetPosition: true,
                                verticalOffset: -(_height * 0.564),
                              ).create(_controller.getAllCartItems()),
                              _transparentGradientShaderMask()
                            ],
                          )))
              ]);
            })));
  }

  Widget _transparentGradientShaderMask() {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(
            Rect.fromLTRB(0, 0, rect.width, rect.height * TRANSPARENCY_LAYER_LISTVIEW));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        color: Colors.white,
      ),
    );
  }

  Builder _addOrderButton(CartController controller) {
    return Builder(builder: (_context) {
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