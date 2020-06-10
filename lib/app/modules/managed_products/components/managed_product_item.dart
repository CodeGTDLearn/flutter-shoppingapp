import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_routes.dart';
import 'package:shopingapp/app/config/titles_icons/components/managed_product_item.dart';

import '../managed_products_controller.dart';

class ManagedProductItem extends StatelessWidget {
  final String _id;
  final String _title;
  final String _imageUrl;

  ManagedProductItem(this._id, this._title, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    final _store = Modular.get<ManagedProductsController>();

    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(_imageUrl)),
        title: Text(_title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  icon: MANAGED_PROD_ITEM_TILE_EDIT_ICO,
                  onPressed: () =>
                      Modular.link.pushNamed('$MANAGPRODUCT_EDIT_ROUTE/$_id'),
                  color: Theme.of(context).errorColor),
              IconButton(
                  icon: MANAGED_PROD_ITEM_TILE_DELETE_ICO,
                  onPressed: () {
                    _store.delete(_id);
                  },
                  color: Theme.of(context).errorColor),
            ])));
  }
}
