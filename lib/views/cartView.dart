import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/cartCardItem.dart';
import '../config/titlesIconsMessages/views/cartView.dart';
import '../services/cartStore.dart';
import '../services/ordersStore.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _cartStore = Modular.get<CartStoreInt>();
  final _orderStore = Modular.get<OrdersStoreInt>();

  @override
  void initState() {
    _cartStore.calcAmount$CartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(CRT_APPBAR_TIT), actions: <Widget>[
          IconButton(
              icon: CRT_ICO_CLRALL,
              onPressed: () => _cartStore.clearCart(),
              tooltip: CRT_ICO_CLRALL_TIP)
        ]),
        body: Column(children: [
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Text(CRT_TXT_CARD, style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Chip(
                        label: Observer(
                            builder: (BuildContext _) => Text(
                                _cartStore.amountCartItems.toStringAsFixed(2),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor))),
                        backgroundColor: Theme.of(context).primaryColor),
                    FlatButton(
                        onPressed: () {
                          _orderStore.addOrder(
                            _cartStore.getAll().values.toList(),
                            _cartStore.amountCartItems,
                          );
                          _cartStore.clearCart();
                        },
                        child: Text(CRT_TXT_ORDER,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)))
                  ]))),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: _cartStore.getAll().length,
                  itemBuilder: (ctx, item) {
                    return CartCardItem(
                        _cartStore.getAll().values.elementAt(item));
                  }))
        ]));
  }
}
