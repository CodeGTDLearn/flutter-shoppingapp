import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/titlesIcons/CartView.dart';

import 'package:shopingapp/entities_models/cartItem.dart';
import 'package:shopingapp/service_stores/cartStore.dart';

class CartCardItem extends StatelessWidget {
  CartItem _cartItem;
  final _cartStore = Modular.get<CartStoreInt>();

  CartCardItem(this._cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(_cartItem.get_id()),
        background: Container(
            child: CRT_ICO_DEL,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2), color: Theme.of(context).errorColor)),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          _cartStore.removeCartItem(_cartItem);
        },
        //
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                  leading: CircleAvatar(
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(child: Text('\$${_cartItem.get_price()}')))),
                  title: Text(_cartItem.get_title()),
                  subtitle:
                      Text('Total \$${(_cartItem.get_price() * _cartItem.get_price()).toStringAsFixed(2)}'),
                  trailing: Text('x${_cartItem.get_price()}')),
            )));
  }
}
