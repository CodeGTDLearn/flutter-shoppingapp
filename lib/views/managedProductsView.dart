import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:shopingapp/config/titlesIconsMessages/widgets/ManagedProductItem.dart';
import 'package:shopingapp/service_stores/managedProductsStore.dart';
import 'package:shopingapp/widgets/drawwer.dart';
import 'package:shopingapp/widgets/managedProductItem.dart';

class ManagedProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _store = Modular.get<ManagedProductsStoreInt>();

    return Scaffold(
      appBar: AppBar(title: Text(MAN_APPBAR_TIT), actions: <Widget>[
        IconButton(
            icon: MAN_ADD_APPBAR_ICO,
            onPressed: () {
              print('add mamaged products');
            })
      ]),
      drawer: Drawwer(),
      body: ListView.builder(
          itemCount: _store.getAll().length,
          itemBuilder: (ctx, item) => Column(children: <Widget>[
                ManagedProductItems(
                  _store.getAll()[item].get_id(),
                  _store.getAll()[item].get_title(),
                  _store.getAll()[item].get_imageUrl(),
                ),
                Divider(),
              ])),
    );
  }
}
