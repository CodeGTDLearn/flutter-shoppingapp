import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../config/app_monitor_builds.dart';
import '../../../config/app_properties.dart';
import '../../../config/titles_icons/views/orders.dart';
import '../order.dart';
import 'order_collapsable_tile_store.dart';

class OrderCollapsableTile extends StatefulWidget {
  final Order _order;
  final _collapseTileStore = Modular.get<OrderCollapsableTileStore>();

  OrderCollapsableTile(this._order);

  @override
  _OrderCollapsableTileState createState() => _OrderCollapsableTileState();
}

class _OrderCollapsableTileState extends State<OrderCollapsableTile> {
  @override
  void initState() {
    widget._collapseTileStore.collapsingTileIcon = ORDERS_ICO_COLLAPSE;
    widget._collapseTileStore.isTileCollapsed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_COMP_ORDERCOLLAP_TILE);
    widget._collapseTileStore.collapsingTileIcon ??= ORDERS_ICO_COLLAPSE;
    return Observer(
        builder: (_) => Card(
            margin: EdgeInsets.all(15),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [_boxShadow(Colors.grey, 5.0)]),
                child: ListTile(
                    dense: true,
                    title: Text(widget._order.get_amount().toStringAsFixed(2)),
                    subtitle: Text(DateFormat(DATE_FORMAT)
                        .format(widget._order.get_datetime())),
                    trailing: IconButton(
                        icon: widget._collapseTileStore.collapsingTileIcon,
                        onPressed: () =>
                            widget._collapseTileStore.toggleCollapseTile())),
              ),
              Visibility(
                  visible: widget._collapseTileStore.isTileCollapsed,
                  child: Container(
                      height: widget._order.get_cartItemsList().length * 48.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: Colors.white,
                          boxShadow: [_boxShadow(Colors.grey, 5.0)]),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: LayoutBuilder(builder: (_, specs) {
                        return ListView(
                            padding: EdgeInsets.all(5),
                            children: widget._order
                                .get_cartItemsList()
                                .map((item) => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          _rowContainer('${item.get_title()}',
                                              18, specs.maxWidth * 0.55),
                                          _rowContainer('x${item.get_qtde()}',
                                              18, specs.maxWidth * 0.15),
                                          _rowContainer(
                                              '${item.get_price().toString()}',
                                              18,
                                              specs.maxWidth * 0.2)
                                        ]))
                                .toList());
                      })))
            ])));
  }

  BoxShadow _boxShadow(Color color, double radius) {
    return BoxShadow(
        color: color, offset: Offset(1.0, 1.0), blurRadius: radius);
  }

  Container _rowContainer(String text, int fonSize, double width) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        alignment: Alignment.centerLeft,
//        color: Colors.amber,
        width: width,
        child: Text(text,
            style: TextStyle(
                fontSize: fonSize.toDouble(), fontWeight: FontWeight.bold)));
  }
}
