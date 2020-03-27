import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../service_stores/ItemsOverviewGridProductItemStore.dart';
import '../entities_models/product.dart';
import '../config/titlesIcons.dart';

class GridProductItem extends StatelessWidget {
  Product _product;
  var _servStore = Modular.get<IItemsOverviewGridProductItemStore>();
  GridProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    print('rebuildando tudo');

    return ClipRect(
        child: GridTile(
            child: GestureDetector(
                onTap: null, child: Image.network(_product.imageUrl, fit: BoxFit.cover)),
            footer: GridTileBar(
                leading: IconButton(
                    icon: Observer(
                        builder: (BuildContext context) =>
                            _servStore.favoriteStatus ?? _product.isFavorite
                                ? IOS_ICO_FAV
                                : IOS_ICO_NOFAV),
                    onPressed: () => _servStore.toggleFavoriteStatus(_product.id),
                    color: Theme.of(context).accentColor),
                title: Text(_product.title),
                trailing: IconButton(
                    icon: IOS_ICO_SHOP, onPressed: null, color: Theme.of(context).accentColor),
                backgroundColor: Colors.black87)));
  }
}
