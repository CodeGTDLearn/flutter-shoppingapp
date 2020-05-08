import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/service_stores/CartStore.dart';

import '../service_stores/ItemsOverviewGridProductItemStore.dart';
import '../entities_models/Product.dart';
import '../config/titlesIcons.dart';

class GridProductItem extends StatelessWidget {
  Product _product;
  var _GridProductItemServStore =
      Modular.get<ItemsOverviewGridProductItemStoreInt>();
  var _CartServStore = Modular.get<CartStoreInt>();

  GridProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: GridTile(
            child: GestureDetector(
                onTap: () =>
                    Modular.to.pushNamed(RT_ITEM_DETAILS + _product.get_id()),
                child:
                    Image.network(_product.get_imageUrl(), fit: BoxFit.cover)),
            footer: GridTileBar(
                leading: IconButton(
                    icon: Observer(
                        builder: (BuildContext context) =>
                            _GridProductItemServStore.favoriteStatus ??
                                    _product.get_isFavorite()
                                ? IOS_ICO_FAV
                                : IOS_ICO_NOFAV),
                    onPressed: () {
                      _GridProductItemServStore.toggleFavoriteStatus(
                          _product.get_id());
                    },
                    color: Theme.of(context).accentColor),
                title: Text(_product.get_title()),
                trailing: IconButton(
                    icon: IOS_ICO_SHOP,
                    onPressed: () {
                      _CartServStore.addCartItem(_product);
                    },
                    color: Theme.of(context).accentColor),
                backgroundColor: Colors.black87)));
  }
}
