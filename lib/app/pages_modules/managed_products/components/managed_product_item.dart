import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_routes.dart';
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
    var test = '$K_MAN_PROD_DEL_BTN$_id';
    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(_imageUrl)),
        title: Text(_title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  key: Key('$K_MAN_PROD_UPD_BTN$_id'),
                  icon: MAN_PROD_ITEM_EDIT_ICO,
                  onPressed: () => Get.toNamed(
                      AppRoutes.MANAGED_PRODUCTS_ADDEDIT_PAGE,
                      arguments: _id),
                  color: Theme.of(context).errorColor),
              IconButton(
                  key: Key('$K_MAN_PROD_DEL_BTN$_id'),
                  icon: MAN_PROD_ITEM_DELETE_ICO,
                  onPressed: () =>
                      _controller.deleteProduct(_id).then((response) {
                        if (response >= 400) {
                          // CustomSnackbar.simple(
                          //     message: ERROR_MAN_PROD, context: context);
                          SimpleSnackbar(ERROR_MAN_PROD, context).show();
                        } else {
                          // CustomSnackbar.simple(
                          //     message: SUCESS_MAN_PROD_DEL, context: context);
                          SimpleSnackbar(SUCESS_MAN_PROD_DEL, context).show();
                        }
                      }),
                  color: Theme.of(context).errorColor),
            ])));
  }
}
