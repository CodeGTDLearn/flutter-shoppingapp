import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/snackbarr.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../orders/core/messages_snackbars_provided.dart';
import '../controller/cart_controller.dart';
import '../core/cart_texts_icons_provided.dart';
import '../entities/cart_item.dart';

class DismisCartItem extends StatelessWidget {
  final CartItem _cartItem;
  final CartController controller = Get.find();

  DismisCartItem.DimissCartItem(this._cartItem);

  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(_cartItem.id),
        background: Container(
            child: CRT_ICO_DISM,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Theme.of(context).errorColor)),
        direction: DismissDirection.endToStart,
        //
        onDismissed: (direction) {
          controller.removeCartItem(_cartItem);
          if (controller.getQtdeCartItemsObs().isEqual(0)) {
            // Get.snackbar(SUCES, QUIT_AFTER_DELS);
            SimpleSnackbar(SUCES, QUIT_AFTER_DELS).show();
            Future.delayed(Duration(milliseconds: DURATION))
                .then((value) => Get.back());
          }
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
                            child: FittedBox(child: Text('\$${_cartItem.price}')))),
                    title: Text(_cartItem.title),
                    subtitle:
                        Text('Total \$${(_cartItem.price).toStringAsFixed(2)}'),
                    trailing: Text('x${_cartItem.qtde}')))),
        //
        confirmDismiss: (direction) {
          return showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                      title: Text(CRT_LBL_CONF_DISM),
                      content: Text('$CRT_MSG_CONF_DISM${_cartItem.title}'
                          ' from the cart?'),
                      actions: <Widget>[
                        _flatButton(YES, true, context),
                        _flatButton(NO, false, context)
                      ]));
        });
  }

  FlatButton _flatButton(String label, bool remove, BuildContext context) {
    return FlatButton(
      key: Key('btn${_cartItem.id}'),
      onPressed: () => Navigator.of(context).pop(remove),
      child: Text(label),
    );
  }
}
