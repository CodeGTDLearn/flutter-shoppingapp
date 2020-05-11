import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons/ItemOverviewView.dart';
import 'package:shopingapp/config/titlesIcons/flushbarNotifications.dart';
import 'package:shopingapp/service_stores/cartStore.dart';

import '../service_stores/itemsOverviewGridProductItemStore.dart';
import '../entities_models/product.dart';

import 'flushNotifier.dart';

class GridProductItem extends StatefulWidget {
  Product _product;

  GridProductItem(this._product);

  @override
  _GridProductItemState createState() => _GridProductItemState();
}

class _GridProductItemState extends State<GridProductItem> {
  var _gridProductItemStore =
      Modular.get<ItemsOverviewGridProductItemStoreInt>();

  var _cartStore = Modular.get<CartStoreInt>();

  List<ReactionDisposer> disposers;

  @override
  void initState() {
    disposers = [
      reaction<int>((fn) => _cartStore.totalQtdeCartItems,
              (notify) {
            if (notify % 2 == 0) {
              FlushNotifier(
                  widget._product.get_title(), MSG_CART_ADD, FLSH_TIME, context)
                  .withButton(UNDO,
                      () => _cartStore.undoAddProductInTheCart(widget._product));
            }
            FlushNotifier(
                "ITEM REMOVED!!!",
                widget._product.get_title() + ": " + MSG_CART_REM,
                FLSH_TIME,
                context)
                .simple();
          })
//      reaction<bool>((fn) => _cartStore.addProductInTheCartNotification,
//          (notify) {
//        if (notify) {
//          FlushNotifier(
//                  widget._product.get_title(), MSG_CART_ADD, FLSH_TIME, context)
//              .withButton(UNDO,
//                  () => _cartStore.undoAddProductInTheCart(widget._product));
//        }
//        FlushNotifier(
//                "ITEM REMOVED!!!",
//                widget._product.get_title() + ": " + MSG_CART_REM,
//                FLSH_TIME,
//                context)
//            .simple();
//      })
    ];
    super.initState();
  }

  void dispose() {
    disposers.forEach((dispose) => dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: GridTile(
            child: GestureDetector(
                onTap: () => Modular.to
                    .pushNamed(RT_ITEM_DETAILS + widget._product.get_id()),
                child: Image.network(widget._product.get_imageUrl(),
                    fit: BoxFit.cover)),
            footer: GridTileBar(
                leading: IconButton(
                    icon: Observer(
                        builder: (BuildContext context) =>
                            _gridProductItemStore.favoriteStatus ??
                                    widget._product.get_isFavorite()
                                ? IOS_ICO_FAV
                                : IOS_ICO_NOFAV),
                    onPressed: () => _gridProductItemStore
                        .toggleFavoriteStatus(widget._product.get_id()),
                    color: Theme.of(context).accentColor),
                title: Text(widget._product.get_title()),
                trailing: IconButton(
                    icon: IOS_ICO_SHOP,
                    onPressed: () =>
                        _cartStore.addProductInTheCart(widget._product),
                    color: Theme.of(context).accentColor),
                backgroundColor: Colors.black87)));
  }
}
