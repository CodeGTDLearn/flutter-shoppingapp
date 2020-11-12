import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_routes.dart';
import '../../pages_generic_components/custom_snackbar.dart';
import '../controller/managed_products_controller.dart';
import '../core/messages/messages_snackbars_provided.dart';
import '../core/texts_icons/managed_product_item_texts_icons_provided.dart';

class ManagedProductItem extends StatelessWidget {
  final String _id;
  final String _title;
  final String _imageUrl;

  ManagedProductItem(this._id, this._title, this._imageUrl);

  final ManagedProductsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(_imageUrl)),
        title: Text(_title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  icon: MAN_PROD_ITEM_EDIT_ICO,
                  onPressed: () => Get.toNamed(
                      AppRoutes.MANAGED_PRODUCTS_ADD_EDIT,
                      arguments: _id),
                  color: Theme.of(context).errorColor),
              IconButton(
                  icon: MAN_PROD_ITEM_DELETE_ICO,
                  onPressed: () =>
                      _controller.deleteProduct(_id).then((response) {
                        if (response >= 400) {
                          // CustomSnackbar.simple(OPS, ERROR_MAN_PROD);
                          // CustomFlushbar(OPS, ERROR_MAN_PROD, context).simple();
                          CustomSnackbar.simple(
                              message: ERROR_MAN_PROD, context: context);
                        } else {
                          // CustomSnackbar.simple(SUCESS, SUCESS_MAN_PROD_DEL);
                          // CustomFlushbar(SUCESS, SUCESS_MAN_PROD_DEL, context)
                          //     .simple();
                          CustomSnackbar.simple(
                              message: SUCESS_MAN_PROD_DEL, context: context);
                        }
                      }),
                  color: Theme.of(context).errorColor),
            ])));
  }
}
