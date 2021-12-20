import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../core/properties/app_properties.dart';
import '../../../../core/texts_icons_provider/pages/order/orders.dart';
import '../../entity/order.dart';

class ExpandableTile extends StatelessWidget {
  final Order _order;

  ExpandableTile(this._order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(13),
      child: Container(
        decoration:
            BoxDecoration(color: Colors.white, boxShadow: [_boxShadow(Colors.grey, 5.0)]),
        child: ExpandablePanel(
          header: Column(
            children: [
              Text("$ORDERS_LABEL_CARD${_order.amount}"),
              Text(DateFormat(DATE_FORMAT).format(DateTime.parse(_order.datetime))),
            ],
          ),
          collapsed: Text(
            "$ORDERS_LABEL_CARD${_order.amount}",
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          expanded: _getCartItems(),
        ),
      ),
    );
  }

  Container _getCartItems() {
    return Container(
        height: _order.cartItems.length * 48.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Colors.white,
            boxShadow: [_boxShadow(Colors.grey, 5.0)]),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: LayoutBuilder(builder: (_, specs) {
          return ListView(
              padding: EdgeInsets.all(5),
              children: _order.cartItems
                  .map((item) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _rowContainer('${item.title}', 18, specs.maxWidth * 0.55),
                            _rowContainer('x${item.qtde}', 18, specs.maxWidth * 0.15),
                            _rowContainer(
                                '${item.price.toString()}', 18, specs.maxWidth * 0.2)
                          ]))
                  .toList());
        }));
  }

  BoxShadow _boxShadow(Color color, double radius) {
    return BoxShadow(color: color, offset: Offset(1.0, 1.0), blurRadius: radius);
  }

  Container _rowContainer(String text, int fonSize, double width) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        alignment: Alignment.centerLeft,
        width: width,
        child: Text(text,
            style: TextStyle(fontSize: fonSize.toDouble(), fontWeight: FontWeight.bold)));
  }
}