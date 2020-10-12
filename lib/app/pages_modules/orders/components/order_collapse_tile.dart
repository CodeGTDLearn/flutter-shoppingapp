import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/pages/orders.dart';
import '../core/orders_texts_icons_provided.dart';
import '../entities/order.dart';
import 'order_collapse_tile_controller.dart';


class OrderCollapseTile extends StatelessWidget {
  final Order _order;

  OrderCollapseTile(this._order);

  @override
  Widget build(BuildContext context) {
    var _controller = OrderCollapseTileController();

    return Card(
        margin: EdgeInsets.all(15),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: [_boxShadow(Colors.grey, 5.0)]),
            child: ListTile(
                dense: true,
                title: Text("$ORDERS_LABEL_CARD: ${_order.amount}"),
                subtitle:
                    Text(DateFormat(DATE_FORMAT).format(DateTime.parse(_order.datetime))),
                trailing: IconButton(
                    icon: Obx(
                      () => _controller.isTileCollapsed.value == false
                          ? ORD_ICO_COLLAPSE
                          : ORD_ICO_UNCOLLAPSE,
                    ),
                    onPressed: _controller.toggleCollapseTile)),
          ),
          Obx(
            () => Visibility(
                visible: _controller.isTileCollapsed.value,
                child: Container(
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
                          children: _order
                              .cartItems
                              .map((item) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _rowContainer('${item.title}', 18,
                                            specs.maxWidth * 0.55),
                                        _rowContainer('x${item.qtde}', 18,
                                            specs.maxWidth * 0.15),
                                        _rowContainer(
                                            '${item.price.toString()}',
                                            18,
                                            specs.maxWidth * 0.2)
                                      ]))
                              .toList());
                    }))),
          )
        ]));
  }

  BoxShadow _boxShadow(Color color, double radius) {
    return BoxShadow(
        color: color, offset: Offset(1.0, 1.0), blurRadius: radius);
  }

  Container _rowContainer(String text, int fonSize, double width) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        alignment: Alignment.centerLeft,
        width: width,
        child: Text(text,
            style: TextStyle(
                fontSize: fonSize.toDouble(), fontWeight: FontWeight.bold)));
  }
}
