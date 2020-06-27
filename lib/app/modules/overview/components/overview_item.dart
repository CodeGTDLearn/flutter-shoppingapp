import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../config/app_monitor_builds.dart';
import '../../../config/app_properties.dart';
import '../../../config/app_routes.dart';
import '../../../config/messages/flush_notifier.dart';
import '../../../config/titles_icons/app_core.dart';
import '../../../config/titles_icons/views/overview.dart';
import '../../../modules/core/components/flush_notifier.dart';
import '../controllers/overview_item_controller.dart';
import '../product.dart';

class OverviewItem extends StatefulWidget {
  final Product _product;

  OverviewItem(this._product);

  @override
  _OverviewItemState createState() => _OverviewItemState();
}

class _OverviewItemState
    extends ModularState<OverviewItem, OverviewItemController> {
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
                        builder: (context) => controller.favoriteStatus ??
                                widget._product.get_isFavorite()
                            ? OVERVIEW_ICO_FAV
                            : OVERVIEW_ICO_NOFAV),
                    onPressed: () => controller
                        .toggleFavoriteStatus(widget._product.get_id()),
                    color: Theme.of(context).accentColor),
                title: Text(widget._product.get_title()),
                trailing: IconButton(
                    icon: OVERVIEW_ICO_SHOP,
                    onPressed: () {
                      controller.cartRepo.addProductInTheCart(widget._product);
                      FlushNotifier(
                              DONE,
                              widget._product.get_title() +
                                  FLUSHNOTIF_MSG_CART_ADD,
                              INTERVAL,
                              context)
                          .withButton(
                        UNDO,
                        () {
                          controller.cartRepo
                              .undoAddProductInTheCart(widget._product);
                        },
                      );
                    },
                    color: Theme.of(context).accentColor),
                backgroundColor: Colors.black87)));
  }
}
