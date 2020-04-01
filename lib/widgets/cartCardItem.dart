import 'package:flutter/material.dart';
import 'package:shopingapp/entities_models/cart_item.dart';

class CartCardItem extends StatelessWidget {
  CartItem _cartItem;

  CartCardItem(this._cartItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('\$${_cartItem.price}')))),
          title: Text(_cartItem.title),
          subtitle: Text('Total \$${(_cartItem.price * _cartItem.qtde)}'),
          trailing: Text('${_cartItem.qtde}'),
        ),
      ),
    );
  }
}
