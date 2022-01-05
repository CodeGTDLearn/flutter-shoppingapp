import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import '../../../../core/icons/modules/orders_icons.dart';
import '../../../../core/properties/app_properties.dart';
import '../../../../core/texts/modules/orders_labels.dart';
import '../../controller/orders_controller.dart';
import '../../entity/order.dart';
import 'icustom_order_tile.dart';

class CollapsableTile implements ICustomOrderTile {
  final _icons = Get.find<OrdersIcons>();
  final _controller = Get.find<OrdersController>();
  final _labels = Get.find<OrdersLabels>();

  @override
  Widget create(Order _order) {
    return Card(
        margin: EdgeInsets.all(15),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [_boxShadow()]),
            child: ListTile(
                dense: true,
                title: Text("${_labels.label_total_tile}${_order.amount}"),
                subtitle:
                    Text(DateFormat(DATE_FORMAT).format(DateTime.parse(_order.datetime))),
                trailing: IconButton(
                    icon: Obx(() => _controller.isTileCollapsed.value == false
                        ? _icons.ico_collapse()
                        : _icons.ico_uncollapse()),
                    onPressed: _controller.toggleCollapseTile)),
          ),
          Obx(() => Visibility(
              visible: _controller.isTileCollapsed.value,
              child: _getCartItemsFromOrder(_order)))
        ]));
  }

  BoxShadow _boxShadow() =>
      BoxShadow(color: Colors.grey, offset: Offset(1.0, 1.0), blurRadius: 5.0);

  Container _getCartItemsFromOrder(Order _order) {
    return Container(
        height: _order.cartItems.length * 48.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Colors.white,
            boxShadow: [_boxShadow()]),
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

  Container _rowContainer(String text, int fonSize, double width) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        alignment: Alignment.centerLeft,
        width: width,
        child: Text(text,
            style: TextStyle(fontSize: fonSize.toDouble(), fontWeight: FontWeight.bold)));
  }
}