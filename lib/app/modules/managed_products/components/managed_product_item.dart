import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

class _ManagedProductItemState
    extends ModularState<ManagedProductItem, ManagedProductsController> {
  @override
  Widget build(BuildContext context) {
    final test = Modular.get<ManagedProductsController>();
    print("222" + test.toString());

    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(widget._imageUrl)),
        title: Text(widget._title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  icon: MANAGED_PROD_ITEM_TILE_EDIT_ICO,
                  onPressed: () => Modular.link
                      .pushNamed('$MANAGPRODUCT_EDIT_ROUTE/${widget._id}'),
                  color: Theme.of(context).errorColor),
              IconButton(
                  icon: MANAGED_PROD_ITEM_TILE_DELETE_ICO,
                  onPressed: () => controller.delete(widget._id),
                  color: Theme.of(context).errorColor),
            ])));
  }
}
