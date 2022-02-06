import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/components/core_adaptive_widgets.dart';
import '../../../../../core/properties/properties.dart';
import '../../../../../core/utils/core_animations_utils.dart';
import '../../../../cart/controller/cart_controller.dart';
import '../../../../cart/entity/cart_item.dart';
import '../../../../overview/controller/overview_controller.dart';
import '../../../../overview/view/overview_item_details_view.dart';
import '../../../entity/order.dart';
import '../../orders_labels.dart';
import 'icustom_order_tile.dart';

class ExpandableTile implements ICustomOrderTile {
  final _cartController = Get.find<CartController>();
  final _overViewController = Get.find<OverviewController>();
  final _widgetUtils = Get.find<CoreAdaptiveWidgets>();
  final size = MediaQuery.of(APP_CONTEXT_GLOBAL_KEY.currentContext!).size;
  final _labels = Get.find<OrdersLabels>();
  final _animations = Get.find<CoreAnimationsUtils>();

  @override
  Widget create(Order _order) {
    return Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 13.0, right: 13.0),
      child: Container(
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(6)),
          //     color: Colors.white,
          //     boxShadow: [_boxShadow()]),
          padding: EdgeInsets.all(5.0),
          child: ExpandablePanel(
              header: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                      "${DateFormat(DATE_FORMAT).format(DateTime.parse(_order.datetime))}",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade200)))),
              collapsed: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 40.0, top: 5.0, bottom: 5.0),
                  width: double.infinity,
                  child: Text("${_labels.total_tile} ${_order.amount}\$")),
              expanded: _showExpandedOrderItems(_order))),
    );
  }

  BoxShadow _boxShadow() =>
      BoxShadow(color: Colors.grey, offset: Offset(1.0, 1.0), blurRadius: 3.0);

  Widget _showExpandedOrderItems(Order _order) {
    return Column(children: [
      Container(
          height: _order.cartItems.length * size.height * 0.16,
          child: LayoutBuilder(builder: (_, dims) {
            return ListView(
                padding: EdgeInsets.only(top: 1, bottom: 1),
                children:
                    _order.cartItems.map((cartItem) => _card(cartItem, dims)).toList());
          })),
      Container(
          alignment: AlignmentDirectional.centerEnd,
          padding: EdgeInsets.all(5.0),
          width: double.infinity,
          child: Text("Final: ${_order.amount}\$",
              style: GoogleFonts.architectsDaughter(
                  textStyle: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ))))
    ]);
  }

  Widget _card(CartItem cartItem, BoxConstraints dims) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8, left: 5, right: 4),
            child: Stack(
              children: [
                Row(children: [
                  Expanded(
                    flex: 3,
                    child: _buttonImage(
                      cartItem.imageUrl,
                      dims.maxWidth * 0.3,
                      cartItem.id,
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _titlePriceQtdeRow(cartItem, dims),
                            _subtotalColumn(cartItem)
                          ]))
                ]),
                Positioned(
                    bottom: 0,
                    left: 85,
                    child: Container(
                        // width: _uiUtils.widthNoContext() * 0.28,
                        // decoration: BoxDecoration(
                        //     color: _colorScheme.primary,
                        //     shape: BoxShape.circle,
                        //     border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
                        //     boxShadow: [_boxShadow()]),
                        child: _widgetUtils.elevatedButton(
                      text: _labels.again,
                      textStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                        shadows: [_boxShadow()],
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      )),
                      onPressed: () => _cartController.addCartItem(
                        _overViewController.getProductById(cartItem.id),
                      ),
                    )))
              ],
            )));
  }

  Row _titlePriceQtdeRow(CartItem cartItem, BoxConstraints dims) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _text('${cartItem.title}', 22, dims.maxWidth * 0.4),
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

    return
        // InkWell(
        // onTap: () => Get.toNamed('${Routes.OVERVIEW_ITEM_DETAILS}$cartItemId'),
        // child:
        _animations.openContainer(
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