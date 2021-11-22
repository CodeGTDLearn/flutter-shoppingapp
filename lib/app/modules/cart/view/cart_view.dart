import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/modules/cart/core/cartview_header.dart';
import 'package:shopingapp/app/modules/cart/core/clear_cart_button.dart';
import 'package:shopingapp/app/modules/cart/core/custom_listview/cart_staggered_listview.dart';

import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/keys/cart_keys.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/cart/cart_texts_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/order/messages_snackbars_provided.dart';
import '../controller/cart_controller.dart';

class CartView extends StatelessWidget {
  final _controller = Get.find<CartController>();

  Widget build(BuildContext context) {
    var fullSizeLessAppbar = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(CRT_TIT_APPBAR),
          actions: [ClearCartButton(_controller)],
        ),
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
                    child: Obx(
                  // () => _controller.qtdeCartItemsObs().isEqual(0)

                  () => _controller.renderStaggeredListView.value
                      ? Container(
                          child: CartStaggeredListview(
                          fade: true,
                          reverse: false,
                          verticalOffset: (_height * 0.625),
                        ).create(_controller.getAllCartItems()))
                      : CartStaggeredListview(
                          fade: false,
                          // Cubic(0.25, 0.1, 0.25, 1.0)
                          // Cubic(0.35, 0.91, 0.33, 0.97)
                          curve: Cubic(1.0, 0.25, 0.1, 0.25),
                          reverse: true,
                          verticalOffset: -(_height * 0.564),
                        ).create(_controller.getAllCartItems()),
                ))
              ]);
            })));
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
// Card _headerCardView(double lbWidth, double lbHeight, BuildContext context) {
//   return Card(
//       margin: EdgeInsets.all(lbWidth * 0.04),
//       child: Padding(
//           padding: EdgeInsets.all(lbWidth * 0.02),
//           child: Container(
//               height: lbHeight * 0.1,
//               child: Row(children: [
//                 Container(
//                     width: lbWidth * 0.15,
//                     child: Text(CRT_LBL_CARD, style: TextStyle(fontSize: 20))),
//                 Container(
//                     width: lbWidth * 0.25,
//                     child: Obx(() => Chip(
//                         label: Text(
//                             _controller.amountCartItemsObs.value.toStringAsFixed(2),
//                             style: TextStyle(color: Colors.white)),
//                         backgroundColor: Theme.of(context).primaryColor))),
//                 SizedBox(width: lbWidth * 0.18),
//                 Container(
//                     width: lbWidth * 0.3,
//                     height: lbHeight * 0.08,
//                     child: Obx(() => _controller.qtdeCartItemsObs().isEqual(0)
//                         ? CustomIndicator.radius(lbWidth * 0.3)
//                         : _addOrderButton(_controller)))
//               ]))));
// }

// IconButton _clearCartItemsButton(CartController controller) {
//   return IconButton(
//       key: Key(K_CRT_CLR_CART_BTN),
//       icon: CRT_ICO_CLEAR,
//       onPressed: () {
//         controller.clearCart.call();
//         SimpleSnackbar(SUCES, SUCES_ORD_CLEAN).show();
//         Future.delayed(Duration(milliseconds: DURATION)).whenComplete(Get.back);
//       },
//       tooltip: CRT_ICO_CLEAR_TOOLT);
// }