import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_snackbar/simple_snackbar.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/cart/cart_texts_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/order/messages_snackbars_provided.dart';
import '../controller/cart_controller.dart';
import '../entity/cart_item.dart';

class DismissibleCartItem extends StatelessWidget {
  final CartItem _cartItem;
  final CartController controller = Get.find();

  DismissibleCartItem.create(this._cartItem);

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
            SimpleSnackbar(SUCES, QUIT_AFTER_DELS).show();
            Future.delayed(Duration(milliseconds: DURATION)).then((value) => Get.back());
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
                    subtitle: Text('Total \$${(_cartItem.price).toStringAsFixed(2)}'),
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
                        _textButton(YES, true, context),
                        _textButton(NO, false, context)
                      ]));
        });
  }

  TextButton _textButton(String label, bool remove, BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(remove),
      child: Text(label),
    );
  }
}