import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/specs.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/entities_models/order.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';

class OrderCollapsableTile extends StatefulWidget {
  final Order _order;
  final _store = Modular.get<OrdersStore>();

  OrderCollapsableTile(this._order);

  @override
  _OrderCollapsableTileState createState() => _OrderCollapsableTileState();
}

class _OrderCollapsableTileState extends State<OrderCollapsableTile> {
  @override
  void initState() {
    widget._store.collapsingIcon = ORD_ICO_EXPMOR;
    widget._store.isCollapsed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(15),
        child: Column(children: [
          Container(
            decoration:
                BoxDecoration(color: Colors.white, boxShadow: [_boxShadow(Colors.grey, 5.0)]),
            child: ListTile(
                dense: true,
                title: Text(widget._order.amount.toStringAsFixed(2)),
                subtitle: Text(DateFormat(DATE_FORM).format(widget._order.datetime)),
                trailing: IconButton(
                    icon: Observer(builder: (BuildContext _) => widget._store.collapsingIcon),
                    onPressed: () => widget._store.toggleCollapseTile())),
          ),
          Observer(
              builder: (BuildContext _) => Visibility(
                    visible: widget._store.isCollapsed,
                    child: Container(
                        height: widget._store.getAll().length * 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: Colors.white,
                            boxShadow: [_boxShadow(Colors.grey, 5.0)]),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: ListView(
                            padding: EdgeInsets.all(5),
                            children: widget._order.cartItemsList
                                .map((item) => Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          _rowContainer('${item.title}', 18),
                                          _rowContainer('x${item.qtde}', 18),
                                          _rowContainer('${item.price.toString()}', 18)
                                        ]))
                                .toList())),
                  ))
        ]));
  }

  BoxShadow _boxShadow(Color color, double radius) {
    return BoxShadow(
      color: color,
      offset: Offset(1.0, 1.0),
      blurRadius: radius,
    );
  }

  Container _rowContainer(String text, int size) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: 100,
        child: Text(
          text,
          style: TextStyle(fontSize: size.toDouble(), fontWeight: FontWeight.bold),
        ));
  }
}
