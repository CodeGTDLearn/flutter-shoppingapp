import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/properties/app_properties.dart';
import '../../../../core/texts_icons_provider/pages/order/orders.dart';
import '../../../cart/entity/cart_item.dart';
import '../../entity/order.dart';
import 'icustom_order_tile.dart';

class ExpandableTile implements ICustomOrderTile {
  final _appContext = APP_CONTEXT_GLOBAL_KEY.currentContext;

  @override
  Widget create(Order _order) {
    return Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 13.0, right: 13.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Colors.white,
              boxShadow: [_boxShadow()]),
          padding: EdgeInsets.all(5.0),
          child: ExpandablePanel(
              header: Container(
                padding: EdgeInsets.all(5.0),
                child: Text(
                    "${DateFormat(DATE_FORMAT).format(DateTime.parse(_order.datetime))}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
              ),
              collapsed: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 40.0, top: 5.0, bottom: 5.0),
                width: double.infinity,
                child: Text("$ORDERS_TOTAL_CARD \$${_order.amount}"),
              ),
              expanded: _showExpandedOrderItems(_order))),
    );
  }

  BoxShadow _boxShadow() =>
      BoxShadow(color: Colors.grey, offset: Offset(1.0, 1.0), blurRadius: 3.0);

  Widget _showExpandedOrderItems(Order _order) {
    return Column(
      children: [
        Container(
          height:
              _order.cartItems.length * MediaQuery.of(_appContext!).size.height * 0.16,
          // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: LayoutBuilder(builder: (_, dimensions) {
            return ListView(
                padding: EdgeInsets.only(top: 1, bottom: 1),
                children: _order.cartItems
                    .map((cartItem) => _card(cartItem, dimensions))
                    .toList());
          }),
        ),
        Container(
            alignment: AlignmentDirectional.centerEnd,
            // decoration: BoxDecoration(
            //     border: Border(top: BorderSide(color: Colors.grey.shade200))),
            padding: EdgeInsets.all(5.0),
            width: double.infinity,
            child: Text(
              "Final: \$${_order.amount}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget _card(CartItem cartItem, BoxConstraints dims) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8, left: 5, right: 4),
            child: Row(children: [
              Expanded(
                  flex: 3, child: _image('${cartItem.imageUrl}', dims.maxWidth * 0.3)),
              Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _titlePriceQtdeRow(cartItem, dims),
                      _subtotalColumn(cartItem),
                    ],
                  )),
            ])));
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
                          letterSpacing: .5,
                          fontWeight: FontWeight.bold)),
                  children: <TextSpan>[
                TextSpan(
                    text: '\$',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 15,
                            letterSpacing: .5,
                            fontWeight: FontWeight.normal)))
              ])),
          Text('x ${cartItem.qtde}', style: TextStyle(fontSize: 18)),
        ],
      )
    ]);
  }

  Column _subtotalColumn(CartItem cartItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Divider(),
        Text('Partial: ${(cartItem.qtde * cartItem.price).toStringAsFixed(2)}',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
              fontSize: 15,
              letterSpacing: .5,
              fontWeight: FontWeight.normal,
            ))),
      ],
    );
  }

  Container _text(String text, int fonSize, double width) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        width: width,
        alignment: AlignmentDirectional.centerStart,
        child: Text(text,
            style: GoogleFonts.andika(
                textStyle: TextStyle(
                    fontSize: 20, letterSpacing: .5, fontWeight: FontWeight.bold))));
  }

  Widget _image(String url, double width) {
    var fadeImage = FadeInImage(
      placeholder: AssetImage(IMAGE_PLACEHOLDER),
      image: NetworkImage(url),
      fit: BoxFit.cover,
    );

    return Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: Colors.white,
            boxShadow: [_boxShadow()]),
        child: ClipRRect(borderRadius: BorderRadius.circular(9.0), child: fadeImage));
  }
}