import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/service_stores/CartStore.dart';

import '../service_stores/ItemsOverviewGridProductItemStore.dart';
import '../entities_models/product.dart';
import '../config/titlesIcons.dart';

class GridProductItem extends StatelessWidget {
  Product _product;
  var _GridProductItemServStore = Modular.get<IItemsOverviewGridProductItemStore>();
  var _CartServStore = Modular.get<ICartStore>();

  GridProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: GridTile(
            child: GestureDetector(
                onTap: () => Modular.to.pushNamed(ROUTE_ITEM_DETAIL + _product.id),
                child: Image.network(_product.imageUrl, fit: BoxFit.cover)),
            footer: GridTileBar(
                leading: IconButton(
                    icon: Observer(
                        builder: (BuildContext context) =>
                        _GridProductItemServStore.favoriteStatus ?? _product.isFavorite
                            ? IOS_ICO_FAV
                            : IOS_ICO_NOFAV),
                    onPressed: () {
                      _GridProductItemServStore.toggleFavoriteStatus(_product.id);
                    },
                    color: Theme
                        .of(context)
                        .accentColor),
                title: Text(_product.title),
                trailing: IconButton(
                    icon: IOS_ICO_SHOP,
                    onPressed: () {
                      _CartServStore.addCartItem(_product);
                    },
                    color: Theme
                        .of(context)
                        .accentColor),
                backgroundColor: Colors.black87)));
  }
}
