import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_routes.dart';
import '../../../config/titles_icons/components/managed_product_item.dart';
import '../managed_products_controller.dart';

class ManagedProductItem extends StatefulWidget {
  final String _id;
  final String _title;
  final String _imageUrl;

  ManagedProductItem(this._id, this._title, this._imageUrl);

  @override
  _ManagedProductItemState createState() => _ManagedProductItemState();
}

class _ManagedProductItemState extends State<ManagedProductItem> {
  final ManagedProductsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(widget._imageUrl)),
        title: Text(widget._title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  icon: MANAGED_PROD_ITEM_TILE_EDIT_ICO,
                  onPressed: () => Get.toNamed(MAN_PROD_ADD_EDIT_ROUTE,
                      arguments: widget._id),
                  color: Theme.of(context).errorColor),
              IconButton(
                  icon: MANAGED_PROD_ITEM_TILE_DELETE_ICO,
                  onPressed: () => controller.delete(widget._id),
                  color: Theme.of(context).errorColor),
            ])));
  }
}
