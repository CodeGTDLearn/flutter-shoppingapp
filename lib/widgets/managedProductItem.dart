import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/routes.dart';
import 'package:shopingapp/service_stores/managedProductsStore.dart';

import '../config/titlesIconsMessages/widgets/managedProductItem.dart';

class ManagedProductItems extends StatelessWidget {
  final String _id;
  final String _title;
  final String _imageUrl;

  ManagedProductItems(this._id, this._title, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    final _store = Modular.get<ManagedProductsStoreInt>();

    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(_imageUrl)),
        title: Text(_title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  icon: MAN_TILE_EDIT_ICO,
                  onPressed: () =>
                      Modular.to.pushReplacementNamed('$MANAGEDPRODUCT_ADD_VIEW/$_id'),
                  color: Theme.of(context).errorColor),
              IconButton(
                  icon: MAN_TILE_DELETE_ICO,
                  onPressed: () => _store.delete(_id),
                  color: Theme.of(context).errorColor),
            ])));
  }
}
