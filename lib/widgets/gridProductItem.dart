import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/service_stores/CartStore.dart';

import '../service_stores/ItemsOverviewGridProductItemStore.dart';
import '../entities_models/Product.dart';
import '../config/titlesIcons.dart';
import 'flushNotifier.dart';

class GridProductItem extends StatelessWidget {
  Product _product;
  var _gridProductItemStore =
      Modular.get<ItemsOverviewGridProductItemStoreInt>();
  var _cartStore = Modular.get<CartStoreInt>();

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
                            _gridProductItemStore.favoriteStatus ??
                                    _product.get_isFavorite()
                                ? IOS_ICO_FAV
                                : IOS_ICO_NOFAV),
                    onPressed: () {
                      _gridProductItemStore
                          .toggleFavoriteStatus(_product.get_id());
                    },
                    color: Theme.of(context).accentColor),
                title: Text(_product.get_title()),
                trailing: IconButton(
                    icon: IOS_ICO_SHOP,
                    onPressed: () {
                      _cartStore.addProductInTheCart(_product);
                      FlushNotifier(DONE, _product.get_title() + MSG_CART_ADD,
                              FLSBR_TIME, context)
                          .withButton(
                        UNDO,
                        () {
                          _cartStore.undoAddProductInTheCart(_product);
                        },
                      );
                    },
                    color: Theme.of(context).accentColor),
                backgroundColor: Colors.black87)));
  }
}
