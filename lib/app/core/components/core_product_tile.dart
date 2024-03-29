import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../modules/cart/entity/cart_item.dart';
import '../../modules/inventory/controller/inventory_controller.dart';
import '../../modules/overview/view/overview_item_details_view.dart';
import '../properties/properties.dart';
import '../texts/core_labels.dart';
import '../utils/core_animations_utils.dart';
import 'core_adaptive_widgets.dart';

class CoreProductTile {
  final _controller = Get.find<InventoryController>();
  final _widgetUtils = Get.find<CoreAdaptiveWidgets>();
  final _animations = Get.find<CoreAnimationsUtils>();
  final _labels = Get.find<CoreLabels>();

  Widget tile(
    CartItem cartItem,
    String label,
    double width,
    double height,
  ) {
    var availabilityProduct = _controller.checkItemAvailability(cartItem.id);

    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8, left: 5, right: 4),
            child: Stack(children: [
              Row(children: [
                Expanded(
                    flex: 3,
                    child: _buttonImageOpenOverviewItemDetail(
                      cartItem.imageUrl,
                      width,
                      height,
                      cartItem.id,
                    )),
                Expanded(
                    flex: 7,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _titlePriceQuantity(cartItem, width),
                          _subtotal(availabilityProduct, cartItem)
                        ]))
              ]),
              Positioned(
                  bottom: 0,
                  left: 85,
                  child: _availabilityTag(availabilityProduct, label))
            ])));
  }

  Container _availabilityTag(bool availabilityProduct, String label) {
    return Container(
        child: _widgetUtils.elevatedButton(
      color: availabilityProduct ? Colors.blue : Colors.red,
      text: availabilityProduct ? label : _labels.unavailable,
      textStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              shadows: [_boxShadow()],
              fontSize: 15,
              color: availabilityProduct ? Colors.white : Colors.yellow,
              fontWeight: FontWeight.normal)),
      onPressed: () => {},
    ));
  }

  BoxShadow _boxShadow() =>
      BoxShadow(color: Colors.grey, offset: Offset(1.0, 1.0), blurRadius: 3.0);

  Row _titlePriceQuantity(CartItem cartItem, double width) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _text('${cartItem.title}', 22, width * 0.95),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        RichText(
            text: TextSpan(
                text: '${cartItem.price.toString()}',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
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
            )))
      ])
    ]);
  }

  Column _subtotal(bool availabilityProduct, CartItem cartItem) {
    var _qtde = cartItem.qtde;
    var _price = cartItem.price;
    var _totalDiscount = cartItem.price * (cartItem.discount / 100) * cartItem.qtde;
    var discountText =
        '${cartItem.discount}% ${_labels.discount}: ${(_totalDiscount)
        .toStringAsFixed(2)}\$';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Divider(),
        Text(availabilityProduct && cartItem.discount != 0 ? discountText : "",
            style: GoogleFonts.alata(
                textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.red,
            ))),
        Divider(),
        Text(
            availabilityProduct
                ? '${_labels.partial} ${((_qtde * _price) - _totalDiscount).toStringAsFixed(2)}\$'
                : "0.00\$",
            style: GoogleFonts.lato(
                textStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
              color: Colors.blue,
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

  Widget _buttonImageOpenOverviewItemDetail(
    String url,
    double width,
    double height,
    String cartItemId,
  ) {
    var availableProduct = _controller.checkItemAvailability(cartItemId);

    var fadeImage = FadeInImage(
      placeholder: AssetImage(IMAGE_PLACEHOLDER),
      image: NetworkImage(url),
      fit: BoxFit.cover,
    );

    var container = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: Colors.white,
            boxShadow: [_boxShadow()]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(9.0),
            child: availableProduct
                ? fadeImage
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.95), // 0 = Colored, 1 = Black & White
                        BlendMode.saturation),
                    child: fadeImage)));
    return availableProduct
        ? _animations.openContainer(
            openingWidget: OverviewItemDetailsView(cartItemId),
            closingWidget: container,
          )
        : container;
    // );
  }
}