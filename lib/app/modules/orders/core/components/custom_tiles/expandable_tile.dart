import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/components/core_product_tile.dart';
import '../../../../../core/properties/properties.dart';
import '../../../entity/order.dart';
import '../../orders_labels.dart';
import 'icustom_order_tile.dart';

class ExpandableTile implements ICustomOrderTile {
  final _size = MediaQuery.of(APP_CONTEXT_GLOBAL_KEY.currentContext!).size;
  final _labels = Get.find<OrdersLabels>();

  @override
  Widget create(Order _order) {
    return Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 13.0, right: 13.0),
      child: Container(
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
                  child: Text("${_labels.totalTile} ${_order.amount}\$")),
              expanded: _listView(_order))),
    );
  }

  Widget _listView(Order order) {
    Get.create(() => CoreProductTile());
    final _productTile = Get.find<CoreProductTile>();

    return Column(children: [
      Container(
          height: order.cartItems.length * _size.height * 0.16,
          child: LayoutBuilder(builder: (_, dims) {
            return ListView(padding: EdgeInsets.only(top: 1, bottom: 1), children: [
              ...order.cartItems.map((cartItem) => _productTile.tile(
                    cartItem,
                    _labels.again,
                    _size.width * 0.33,
                    _size.height * 0.15,
                  ))
            ]);
          })),
      Container(
          alignment: AlignmentDirectional.centerEnd,
          padding: EdgeInsets.all(5.0),
          width: double.infinity,
          child: Text("Final: ${order.amount}\$",
              style: GoogleFonts.architectsDaughter(
                  textStyle: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ))))
    ]);
  }
}