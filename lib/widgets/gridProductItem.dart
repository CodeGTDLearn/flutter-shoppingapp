import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../config/titlesIconsMessages/general.dart';
import '../config/appProperties.dart';
import '../config/titlesIconsMessages/views/ItemOverviewView.dart';
import '../config/titlesIconsMessages/widgets/flushNotifier.dart';
import '../service_stores/cartStore.dart';
import '../service_stores/itemsOverviewGridProductItemStore.dart';
import '../entities/product.dart';
import 'flushNotifier.dart';


class GridProductItem extends StatefulWidget {
  Product _product;

  GridProductItem(this._product);

  @override
  _GridProductItemState createState() => _GridProductItemState();
}

class _GridProductItemState extends State<GridProductItem> {
  var _gridProductItemStore = Modular.get<ItemsOverviewGridProductItemStoreInt>();

  var _cartStore = Modular.get<CartStoreInt>();

  @override
  Widget build(BuildContext context) {
    print('buildando!!!!');
    return ClipRect(
        child: GridTile(
            child: GestureDetector(
                onTap: () => Modular.to.pushNamed(ITEM_DET_VIEW + widget._product.get_id()),
                child: Image.network(widget._product.get_imageUrl(), fit: BoxFit.cover)),
            footer: GridTileBar(
                leading: IconButton(
                    icon: Observer(
                        builder: (BuildContext context) =>
                            _gridProductItemStore.favoriteStatus ?? widget._product.get_isFavorite()
                                ? IOV_ICO_FAV
                                : IOV_ICO_NOFAV),
                    onPressed: () =>
                        _gridProductItemStore.toggleFavoriteStatus(widget._product.get_id()),
                    color: Theme.of(context).accentColor),
                title: Text(widget._product.get_title()),
                trailing: IconButton(
                    icon: IOV_ICO_SHOP,
                    onPressed: () {
                      _cartStore.addProductInTheCart(widget._product);
                      FlushNotifier(
                              DONE, widget._product.get_title() + MSG_CART_ADD, FLSH_TIME, context)
                          .withButton(
                        UNDO,
                        () {
                          _cartStore.undoAddProductInTheCart(widget._product);
                        },
                      );
                    },
                    color: Theme.of(context).accentColor),
                backgroundColor: Colors.black87)));
  }
}
