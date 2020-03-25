import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../entities_models/product.dart';
import '../config/titlesIcons.dart';
import '../service_stores/items_overview_serv_store.dart';

class productItemGridOverview extends StatefulWidget {
  Product _product;

  productItemGridOverview(this._product);

  @override
  _productItemGridOverviewState createState() => _productItemGridOverviewState();
}

class _productItemGridOverviewState extends State<productItemGridOverview> {
  final _servStore = Modular.get<ItemsOverviewServStore>();

  void toggleFavoriteStatus(String id) {
    setState(() {
      _servStore.toggleFavoriteStatus(widget._product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuildando tudo'); //TODO WORK IN FAVORITE ATOMICALLY USUGIN MOBIX
    return ClipRect(
        child: GridTile(
      child: GestureDetector(
          onTap: null, child: Image.network(widget._product.imageUrl, fit: BoxFit.cover)),
      footer: GridTileBar(
          leading: IconButton(
            icon: widget._product.isFavorite ? IOS_ICO_FAV : IOS_ICO_NOFAV,
            onPressed: () => toggleFavoriteStatus(widget._product.id),
            color: Theme.of(context).accentColor,
          ),
          title: Text(this.widget._product.title),
          trailing: IconButton(
            icon: IOS_ICO_SHOP,
            onPressed: null,
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87),
    ));
  }
}
