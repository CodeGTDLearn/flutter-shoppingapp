import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../config/app_monitor_builds.dart';
import '../../../../config/app_properties.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/messages/flush_notifier.dart';
import '../../../../config/titles_icons/app_core.dart';
import '../../../../config/titles_icons/views/overview.dart';
import '../../../core/components/flush_notifier.dart';
import '../../product.dart';
import 'overview_item_service.dart';

class OverviewItem extends StatefulWidget {
  final Product _product;

  OverviewItem(this._product);

  @override
  _OverviewItemState createState() => _OverviewItemState();
}

class _OverviewItemState
    extends ModularState<OverviewItem, OverviewItemService> {
  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_COMP_GRIDPRODITEM);

    return ClipRect(
        child: GridTile(
            child: GestureDetector(
                onTap: () => Modular.link.pushNamed(
                    '$OVERVIEW_DEAIL_ROUTE/${widget._product.get_id()}'),
                child: Image.network(widget._product.get_imageUrl(),
                    fit: BoxFit.cover)),
            footer: GridTileBar(
                leading: IconButton(
                    icon: Observer(
                        builder: (context) => controller.favoriteStatus ??
                                widget._product.get_isFavorite()
                            ? OVERVIEW_ICO_FAV
                            : OVERVIEW_ICO_NOFAV),
                    onPressed: () =>
                        controller.toggleFavorite(widget._product.get_id()),
                    color: Theme.of(context).accentColor),
                title: Text(widget._product.get_title()),
                trailing: IconButton(
                    icon: OVERVIEW_ICO_SHOP,
                    onPressed: () {
                      controller.addCartItem(widget._product);
                      FlushNotifier(
                              DONE,
                              widget._product.get_title() +
                                  FLUSHNOTIF_MSG_CART_ADD,
                              INTERVAL,
                              context)
                          .withButton(
                        UNDO,
                        () {
                          controller.addCartItemUndo(widget._product);
                        },
                      );
                    },
                    color: Theme.of(context).accentColor),
                backgroundColor: Colors.black87)));
  }
}
