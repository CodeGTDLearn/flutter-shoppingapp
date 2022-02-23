import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopingapp/app/core/components/core_product_tile.dart';

import '../../../../core/components/core_alert_dialog.dart';
import '../../../../core/components/snackbar/core_snackbar.dart';
import '../../../../core/properties/properties.dart';
import '../../../../core/texts/core_labels.dart';
import '../../../../core/texts/core_messages.dart';
import '../../controller/cart_controller.dart';
import '../../entity/cart_item.dart';
import '../cart_icons.dart';
import '../cart_labels.dart';

class DismissibleCartItem extends StatelessWidget {
  final CartItem _cartItem;
  final _controller = Get.find<CartController>();
  final _icons = Get.find<CartIcons>();
  final _messages = Get.find<CoreMessages>();
  final _words = Get.find<CoreLabels>();
  final _labels = Get.find<CartLabels>();
  final _item = Get.find<CoreProductTile>();

  DismissibleCartItem.create(this._cartItem);

  @override
  Widget build(BuildContext context) {

    // var fadeImage = FadeInImage(
    //   placeholder: AssetImage(IMAGE_PLACEHOLDER),
    //   image: NetworkImage(_cartItem.imageUrl),
    //   fit: BoxFit.cover,
    // );

    return Dismissible(
        key: Key(_cartItem.id),
        background: Container(
            child: _icons.CRT_ICO_DISM(),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
                color: Theme.of(context).errorColor,
                borderRadius: BorderRadius.circular(2))),
        direction: DismissDirection.endToStart,
        //
        onDismissed: (direction) {
          _controller.removeCartItem(_cartItem);
          if (_controller.qtdeCartItemsObs.value.isEqual(0)) {
            CoreSnackbar().show(_words.suces, _messages.item_removed_cart);
            Future.delayed(Duration(milliseconds: DURATION)).then((value) => Get.back());
          }
        },
        //
        // child: _simplesCard(fadeImage),
        child: _item.tile(_cartItem, 200),
        //
        confirmDismiss: (direction) {
          return CoreAlertDialog.showOptionDialog(
            context,
            _labels.label_title_dialog_dismis,
            '${_labels.label_message_dialog_dismis}${_cartItem.title} from the cart?',
            _words.yes(),
            _words.no(),
            () => {},
            () => {},
          );
        });
  }

  Widget _simplesCard(FadeInImage fadeImage) {
    return Card(
          elevation: 5,
          shadowColor: Colors.black,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0), child: fadeImage),
                  title: Text(_cartItem.title),
                  subtitle: Text('\$${(_cartItem.price).toStringAsFixed(2)}'),
                  trailing: Text('x ${_cartItem.qtde}',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ))))));
  }

  BoxShadow _boxShadow() =>
      BoxShadow(color: Colors.grey, offset: Offset(1.0, 1.0), blurRadius: 3.0);
}