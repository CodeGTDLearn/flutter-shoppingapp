import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../controller/managed_products_controller.dart';
import '../core/managed_products_widget_keys.dart';
import '../core/messages/messages_snackbars_provided.dart';
import '../core/texts_icons/managed_product_item_icons_provided.dart';

class ManagedProductItem extends StatelessWidget {
  final String _id;
  final String _title;
  final String _imageUrl;

  ManagedProductItem(this._id, this._title, this._imageUrl);

  final ManagedProductsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        key: Key('$K_MP_ITEM_KEY$_id'),
        leading: CircleAvatar(backgroundImage: NetworkImage(_imageUrl)),
        title: Text(_title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  key: Key('$K_MP_UPD_BTN$_id'),
                  icon: MAN_PROD_ITEM_UPD_ICO,
                  onPressed: () => Get.toNamed(
                      AppRoutes.MANAGED_PRODUCTS_ADDEDIT_PAGE,
                      arguments: _id),
                  color: Theme.of(context).errorColor),
              IconButton(
                  key: Key('$K_MP_DEL_BTN$_id'),
                  icon: MAN_PROD_ITEM_DEL_ICO,
                  onPressed: () =>
                      _controller.deleteProduct(_id).then((response) {
                        if (response >= 400) {
                          SimpleSnackbar(OPS, ERROR_MAN_PROD).show();
                          // Get.snackbar(OPS, ERROR_MAN_PROD);
                        } else {
                          SimpleSnackbar(SUCES, SUCESS_MAN_PROD_DEL).show();
                          // Get.snackbar(SUCES, SUCESS_MAN_PROD_DEL);
                        }
                      }),
                  color: Theme.of(context).errorColor),
            ])));
  }
}
