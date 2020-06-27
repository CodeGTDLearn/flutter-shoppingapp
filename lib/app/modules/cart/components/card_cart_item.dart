import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../config/titles_icons/app_core.dart';
import '../../../config/titles_icons/views/cart.dart';
import '../cart_controller.dart';
import '../cart_item.dart';

class CardCartItem extends StatelessWidget {
  final CartItem _cartItem;
  final _cartStore = Modular.get<CartController>();

  CardCartItem(this._cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(_cartItem.get_id()),
        background: Container(
            child: CART_ICO_DESMISS,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Theme.of(context).errorColor)),
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
                          child: FittedBox(
                              child: Text('\$${_cartItem.get_price()}')))),
                  title: Text(_cartItem.get_title()),
                  subtitle: Text(
                      'Total \$${(_cartItem.get_price()).toStringAsFixed(2)}'),
                  trailing: Text('x${_cartItem.get_qtde()}')),
            )),
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      title: Text(CART_LBL_CONFIRM_DESMISS),
                      content: Text(CART_MSG_CONFIRM_DESMISS),
                      actions: <Widget>[
                        _flattButton(YES, true),
                        _flattButton(NO, false)
                      ]));
        });
  }

  FlatButton _flattButton(String label, bool remove) {
    return FlatButton(
      onPressed: () {
        Modular.to.pop(remove);
      },
      child: Text(label),
    );
  }
}
