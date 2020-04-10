import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/entities_models/order.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';

class OrderCollapsableTile extends StatefulWidget {
  final Order _order;

  OrderCollapsableTile(this._order);

  @override
  _OrderCollapsableTileState createState() => _OrderCollapsableTileState();
}

class _OrderCollapsableTileState extends State<OrderCollapsableTile> {
  final _store = Modular.get<OrdersStore>();

  @override
  void initState() {
    _store.collapsingIcon = ORD_ICO_EXPMOR;
    _store.isCollapsed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
        child: Column(children: [
      ListTile(
          title: Text(widget._order.amount.toStringAsFixed(2)),
          subtitle: Text(DateFormat(DATE_FORM).format(widget._order.datetime)),
          trailing: IconButton(
              icon: _store.collapsingIcon,
              onPressed: () => _store.toggleCollapseTile())),
      Observer(
          builder: (BuildContext _) => Visibility(
                visible: _store.isCollapsed,
                child: Container(
                    height: _store.getAll().length * 27.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 5.0)
                        ]),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: ListView(
                        padding: EdgeInsets.all(5),
                        children: widget._order.cartItemsList
                            .map((item) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _rowContainer('${item.title}', 18),
                                      _rowContainer('${item.qtde}', 18),
                                      _rowContainer('\$${item.price}', 18)
                                    ]))
                            .toList())),
              ))
    ]));
  }

  Container _rowContainer(String text, int size) {
    Container(
        width: 120,
        child: Text(
          text,
          style:
              TextStyle(fontSize: size.toDouble(), fontWeight: FontWeight.bold),
        ));
  }
}
