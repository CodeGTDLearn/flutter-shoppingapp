import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/service_stores/CartStore.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';
import 'package:shopingapp/widgets/cartCardItem.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _servCartStore = Modular.get<ICartStore>();
  final _servOrderStore = Modular.get<IOrdersStore>();

  @override
  void initState() {
    _servCartStore.calcTotalCartMoneyAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(CRT_APPBAR_TITLE),
          actions: <Widget>[
            IconButton(
                icon: CRT_ICO_CLRALL,
                onPressed: () => _servCartStore.clearCartItems(),
                tooltip: CRT_ICO_CLRALL_TIP)
          ],
        ),
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
                                _servCartStore.totalMoneyCartItems
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .title
                                        .color))),
                        backgroundColor: Theme.of(context).primaryColor),
                    FlatButton(
                        onPressed: () {
                          _servOrderStore.addOrder(
                            _servCartStore.getAll().values.toList(),
                            _servCartStore.totalMoneyCartItems,
                          );
                          _servCartStore.clearCartItems();
                        },
                        child: Text(CRT_TXT_ORDER,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)))
                  ]))),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: _servCartStore.getAll().length,
                  itemBuilder: (ctx, item) {
                    return CartCardItem(
                        _servCartStore.getAll().values.elementAt(item));
                  }))
        ]));
  }
}
