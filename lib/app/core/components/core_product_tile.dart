import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../modules/cart/controller/cart_controller.dart';
import '../../modules/cart/entity/cart_item.dart';
import '../../modules/orders/core/orders_labels.dart';
import '../../modules/overview/controller/overview_controller.dart';
import '../../modules/overview/view/overview_item_details_view.dart';
import '../properties/properties.dart';
import '../utils/core_animations_utils.dart';
import 'core_adaptive_widgets.dart';

class CoreProductTile {
  final _cartController = Get.find<CartController>();
  final _overViewController = Get.find<OverviewController>();
  final _widgetUtils = Get.find<CoreAdaptiveWidgets>();
  final _animations = Get.find<CoreAnimationsUtils>();
  final _labels = Get.find<OrdersLabels>();

  Widget tile(CartItem cartItem, double width) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8, left: 5, right: 4),
            child: Stack(children: [
              Row(children: [
                Expanded(
                    flex: 3,
                    child: _buttonImage(
                      cartItem.imageUrl,
                      width * 0.3,
                      cartItem.id,
                    )),
                Expanded(
                    flex: 7,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _titlePriceQtdeRow(cartItem, width),
                          _subtotalColumn(cartItem)
                        ]))
              ]),
              Positioned(
                  bottom: 0,
                  left: 85,
                  child: Container(
                      child: _widgetUtils.elevatedButton(
                          text: _labels.again,
                          textStyle: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  shadows: [_boxShadow()],
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)),
                          onPressed: () => _cartController.addCartItem(
                                _overViewController.getProductById(cartItem.id),
                              ))))
            ])));
  }

  BoxShadow _boxShadow() =>
      BoxShadow(color: Colors.grey, offset: Offset(1.0, 1.0), blurRadius: 3.0);

  Row _titlePriceQtdeRow(CartItem cartItem, double width) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _text('${cartItem.title}', 22, width * 0.4),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
              text: TextSpan(
                  text: '${cartItem.price.toString()}',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  children: <TextSpan>[
                TextSpan(
                    text: '\$',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    )))
              ])),
          Text('x ${cartItem.qtde}',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ))),
        ],
      )
    ]);
  }

  Column _subtotalColumn(CartItem cartItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Divider(),
        Text('Partial: ${(cartItem.qtde * cartItem.price).toStringAsFixed(2)}\$',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ))),
      ],
    );
  }

  Container _text(String text, int fonSize, double width) {
    return Container(
        padding: EdgeInsets.only(left: 10, bottom: 15),
        width: width,
        alignment: AlignmentDirectional.centerStart,
        child: Text(text,
            style: GoogleFonts.andika(
                textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ))));
  }

  Widget _buttonImage(String url, double width, String cartItemId) {
    var fadeImage = FadeInImage(
      placeholder: AssetImage(IMAGE_PLACEHOLDER),
      image: NetworkImage(url),
      fit: BoxFit.cover,
    );

    return _animations.openContainer(
      openingWidget: OverviewItemDetailsView(cartItemId),
      closingWidget: Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.0),
              color: Colors.white,
              boxShadow: [_boxShadow()]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9.0),
            child: fadeImage,
          )),
    );
    // );
  }
}