import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
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
                  onPressed: () =>
                      Get.toNamed(AppRoutes.MAN_PROD_ADD_EDIT, arguments: _id),
                  color: Theme.of(context).errorColor),
              IconButton(
                  icon: MAN_PROD_ITEM_DELETE_ICO,
                  onPressed: () =>
                      _controller.deleteProduct(_id).then((response) {
                        if (response >= 400) {
                          CustomSnackBar.simple(OPS, ERROR_MAN_PROD);
                        } else {
                          CustomSnackBar.simple(SUCESS, SUCESS_MAN_PROD_DEL);
                        }
                      }),
                  color: Theme.of(context).errorColor),
            ])));
  }
}
