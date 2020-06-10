import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_monitor_builds.dart';
import 'package:shopingapp/app/config/app_properties.dart';
import 'package:shopingapp/app/config/app_routes.dart';
import 'package:shopingapp/app/config/messages/flush_notifier.dart';
import 'package:shopingapp/app/config/titles_icons/app_core.dart';
import 'package:shopingapp/app/config/titles_icons/views/overview.dart';
import 'package:shopingapp/app/modules/cart/cart_controller.dart';
import 'package:shopingapp/app/modules/core/components/flush_notifier.dart';

import '../overview_grid_product_item_controller.dart';
import '../product.dart';

class GridProductItem extends StatefulWidget {
  final Product _product;

  GridProductItem(this._product);

  @override
  _GridProductItemState createState() => _GridProductItemState();
}

class _GridProductItemState
    extends ModularState<GridProductItem, CartController> {
  var _gridProductItemStore = Modular.get<OverviewGridProductItemController>();

  var _cartStore = Modular.get<CartControllerBase>();
  int cont = 0;

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_COMP_GRIDPRODITEM);
    return ClipRect(
        child: GridTile(
            child: GestureDetector(
                onTap: () => Modular.link.pushNamed(
                    '$ITEMDETAILS_ROUTE/${widget._product.get_id()}'),
                child: Image.network(widget._product.get_imageUrl(),
                    fit: BoxFit.cover)),
            footer: GridTileBar(
                leading: IconButton(
                    icon: Observer(
                        builder: (BuildContext context) =>
                            _gridProductItemStore.favoriteStatus ??
                                    widget._product.get_isFavorite()
                                ? OVERVIEW_ICO_FAV
                                : OVERVIEW_ICO_NOFAV),
                    onPressed: () => _gridProductItemStore
                        .toggleFavoriteStatus(widget._product.get_id()),
                    color: Theme.of(context).accentColor),
                title: Text(widget._product.get_title()),
                trailing: IconButton(
                    icon: OVERVIEW_ICO_SHOP,
                    onPressed: () {
                      _cartStore.addProductInTheCart(widget._product);
                      FlushNotifier(
                              DONE,
                              widget._product.get_title() +
                                  FLUSHNOTIF_MSG_CART_ADD,
                              INTERVAL,
                              context)
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
