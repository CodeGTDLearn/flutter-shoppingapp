import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../core/custom_widgets/custom_alert_dialog.dart';
import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/cart/cart_texts_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/order/messages_snackbars_provided.dart';
import '../controller/cart_controller.dart';
import '../entity/cart_item.dart';

class DismissibleCartItem extends StatelessWidget {
  final CartItem _cartItem;
  final _controller = Get.find<CartController>();

  DismissibleCartItem.create(this._cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(_cartItem.id),
        background: Container(
          child: CRT_ICO_DISM,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          decoration: BoxDecoration(
              color: Theme.of(context).errorColor,
              borderRadius: BorderRadius.circular(2)),
        ),
        direction: DismissDirection.endToStart,
        //
        onDismissed: (direction) {
          _controller.removeCartItem(_cartItem);
          if (_controller.getQtdeCartItemsObs().isEqual(0)) {
            SimpleSnackbar(SUCES, QUIT_AFTER_DELS).show();
            Future.delayed(Duration(milliseconds: DURATION)).then((value) => Get.back());
          }
        },
        //
        child: Card(
            elevation: 5,
            shadowColor: Colors.black,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                    leading: CircleAvatar(
                        child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(child: Text('\$${_cartItem.price}')),
                      // child: Image.network(_cartItem.imageUrl, fit: BoxFit.cover),
                    )),
                    title: Text(_cartItem.title),
                    subtitle: Text('Total \$${(_cartItem.price).toStringAsFixed(2)}'),
                    trailing: Text('x${_cartItem.qtde}')))),
        //
        confirmDismiss: (direction) {
          return CustomAlertDialog.showOptionDialog(
            context,
            CRT_LBL_CONF_DISM,
            '$CRT_MSG_CONF_DISM${_cartItem.title} from the cart?',
            YES,
            NO,
            () => {},
            () => {},
          );
        });
  }

// Future<bool?> _showDialog(context, String title, content) {
//   var _navCtx = Navigator.of(context);
//   return showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//             title: Text(title),
//             content: Text(content),
//             actions: <Widget>[
//               TextButton(onPressed: () => _navCtx.pop(true), child: Text(YES)),
//               TextButton(onPressed: () => _navCtx.pop(false), child: Text(NO)),
//             ],
//           ));
// }
}